import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fteam_authentication_core/fteam_authentication_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'errors/firebase_auth_error.dart';
import 'providers/provider_service.dart';

class FirebaseDatasource implements AuthDatasource {
  final FirebaseAuth firebaseAuth;
  final ProviderService provider;

  FirebaseDatasource({required this.provider, required this.firebaseAuth});

  @override
  Future<LoggedUser?> getLoggedUser() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      return null;
    }

    return _userFactory(
      user,
      _getProviderLogin(user.providerData),
    );
  }

  List<ProviderLogin> _getProviderLogin(List<UserInfo> userInfos) {
    final providers =
        userInfos.map((provider) => _verifyProvider(provider.providerId));
    return providers.toList();
  }

  ProviderLogin _verifyProvider(String provider) {
    if (provider == ProviderLogin.google.provider) {
      return ProviderLogin.google;
    } else if (provider == ProviderLogin.facebook.provider) {
      return ProviderLogin.facebook;
    } else if (provider == ProviderLogin.appleId.provider) {
      return ProviderLogin.appleId;
    } else if (provider == ProviderLogin.phone.provider) {
      return ProviderLogin.phone;
    } else {
      return ProviderLogin.emailSignin;
    }
  }

  @override
  Future<LoggedUser?> loginWithAppleId() async {
    AuthorizationCredentialAppleID credential;
    try {
      credential = await provider.appleAuth();
    } catch (e, st) {
      throw CredentialsError(
          message: 'firebaseDatasource.credentialError',
          mainException: e,
          stacktrace: st);
    }
    var oAuthProvider = OAuthProvider('apple.com');
    var cred = oAuthProvider.credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );

    var result = await firebaseAuth.signInWithCredential(cred);
    final user = result.user;
    if (user == null) return null;

    if (credential.email != null && credential.givenName != null) {
      await user.updateEmail(credential.email!);
      await user.updateDisplayName(
          '${credential.givenName} ${credential.familyName}');

      return LoggedUser(
        name: '${credential.givenName} ${credential.familyName}',
        uid: user.uid,
        email: user.email ?? '',
        providers: [ProviderLogin.appleId],
        token: await user.getIdToken(true),
      );
    }

    return _userFactory(user, _getProviderLogin(user.providerData));
  }

  @override
  Future<LoggedUser?> loginWithFacebook() async {
    FacebookAuthCredential? credential;
    try {
      credential = await provider.facebookAuth();
    } catch (e, st) {
      throw CredentialsError(
          message: 'firebaseDatasource.credentialError',
          mainException: e,
          stacktrace: st);
    }
    if (credential == null) throw CredentialsError(message: 'Null credential');
    await provider.facebookSignIn.logOut();
    var result = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = result.user;
    if (user == null) return null;
    return _userFactory(user, _getProviderLogin(user.providerData));
  }

  @override
  Future<LoggedUser?> loginWithGoogle() async {
    GoogleSignInAuthentication? signInAuthenticationResult;
    try {
      signInAuthenticationResult = await provider.googleAuth();
    } catch (e, st) {
      throw CredentialsError(
          message: 'firebaseDatasource.credentialError',
          mainException: e,
          stacktrace: st);
    }
    if (signInAuthenticationResult == null) return null;
    final credential = GoogleAuthProvider.credential(
      accessToken: signInAuthenticationResult.accessToken,
      idToken: signInAuthenticationResult.idToken,
    );

    await provider.googleSignIn.signOut();
    var result = await FirebaseAuth.instance.signInWithCredential(credential);
    final user = result.user;
    if (user == null) return null;
    return _userFactory(user, _getProviderLogin(user.providerData));
  }

  Future<LoggedUser> _userFactory(
      User firebaseUser, List<ProviderLogin> providers) async {
    final token = await firebaseUser.getIdToken(true);
    return LoggedUser(
      email: firebaseUser.email ?? '',
      uid: firebaseUser.uid,
      name: firebaseUser.displayName ?? '',
      emailVerified: firebaseUser.emailVerified,
      urlPhoto: firebaseUser.photoURL ?? '',
      token: token,
      providers: providers,
    );
  }

  @override
  Future<int> logout() async {
    await firebaseAuth.signOut();
    return 0;
  }

  @override
  Future<LoggedUser?> unlinkAccount(ProviderLogin provider) async {
    var user = firebaseAuth.currentUser;
    if (user == null) {
      throw NotUserLogged();
    }
    switch (provider) {
      case ProviderLogin.google:
        user = await user.unlink('google.com');
        break;
      case ProviderLogin.facebook:
        user = await user.unlink('facebook.com');
        break;
      case ProviderLogin.appleId:
        user = await user.unlink('apple.com');
        break;
      case ProviderLogin.emailSignin:
        user = await user.unlink('email');
        break;
      default:
        return null;
    }

    return _userFactory(user, _getProviderLogin(user.providerData));
  }

  @override
  FutureOr<LoggedUser?> linkAccount(ProviderLogin providerLogin) {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw NotUserLogged();
    }
    switch (providerLogin) {
      case ProviderLogin.google:
        return _linkGoogle(user);
      case ProviderLogin.facebook:
        return _linkFacebook(user);
      case ProviderLogin.appleId:
        return _linkAppleId(user);
      default:
        return null;
    }
  }

  Future<LoggedUser?> _linkGoogle(User user) async {
    GoogleSignInAuthentication? signInAuthenticationResult;
    try {
      signInAuthenticationResult = await provider.googleAuth();
    } catch (e, st) {
      throw CredentialsError(
          message: 'firebaseDatasource.credentialError',
          mainException: e,
          stacktrace: st);
    }
    if (signInAuthenticationResult == null) return null;
    final credential = GoogleAuthProvider.credential(
      accessToken: signInAuthenticationResult.accessToken,
      idToken: signInAuthenticationResult.idToken,
    );

    await provider.googleSignIn.signOut();
    UserCredential result;
    try {
      result = await user.linkWithCredential(credential);
    } on FirebaseAuthException catch (e, st) {
      throw checkFirebaseAuthError(e.code, exc: e, stackTrace: st);
    }
    final resultUser = result.user;
    if (resultUser == null) return null;

    return _userFactory(resultUser, _getProviderLogin(resultUser.providerData));
  }

  Future<LoggedUser?> _linkFacebook(User user) async {
    FacebookAuthCredential? credential;
    try {
      credential = await provider.facebookAuth();
    } catch (e, st) {
      throw CredentialsError(
          message: 'firebaseDatasource.credentialError',
          mainException: e,
          stacktrace: st);
    }
    if (credential == null) return null;
    await provider.facebookSignIn.logOut();
    UserCredential result;
    try {
      result = await user.linkWithCredential(credential);
    } on FirebaseAuthException catch (e, st) {
      throw checkFirebaseAuthError(e.code, exc: e, stackTrace: st);
    }
    final resultUser = result.user;
    if (resultUser == null) return null;

    return _userFactory(resultUser, _getProviderLogin(resultUser.providerData));
  }

  Future<LoggedUser?> _linkAppleId(User user) async {
    AuthorizationCredentialAppleID authorizationCredentialAppleID;
    try {
      authorizationCredentialAppleID = await provider.appleAuth();
    } catch (e, st) {
      throw CredentialsError(
          message: 'firebaseDatasource.credentialError',
          mainException: e,
          stacktrace: st);
    }
    var oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: authorizationCredentialAppleID.identityToken,
      accessToken: authorizationCredentialAppleID.authorizationCode,
    );

    UserCredential result;
    try {
      result = await user.linkWithCredential(credential);
    } on FirebaseAuthException catch (e, st) {
      throw checkFirebaseAuthError(e.code, exc: e, stackTrace: st);
    } catch (e) {
      rethrow;
    }
    final resultUser = result.user;
    if (resultUser == null) return null;

    return _userFactory(resultUser, _getProviderLogin(resultUser.providerData));
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await firebaseAuth.currentUser?.delete();
    } on FirebaseException catch (e, st) {
      throw checkFirebaseAuthError(e.code, stackTrace: st, exc: e);
    }
  }

  @override
  Future<LoggedUser?> signupWithEmail(EmailCredencials credencials) async {
    try {
      var userCredential = await firebaseAuth.createUserWithEmailAndPassword(
          email: credencials.email, password: credencials.password);
      final user = userCredential.user;
      if (user == null) return null;
      return _userFactory(user, _getProviderLogin(user.providerData));
    } on FirebaseAuthException catch (e, st) {
      throw checkFirebaseAuthError(e.code, exc: e, stackTrace: st);
    } catch (e, st) {
      throw EmailLoginError(
        message: 'Datasource error',
        mainException: e,
        stacktrace: st,
      );
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    var user = firebaseAuth.currentUser;
    if (user == null) return;
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  @override
  Future<LoggedUser?> loginWithEmail(EmailCredencials credencials) async {
    try {
      var userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: credencials.email, password: credencials.password);
      final user = userCredential.user;
      if (user == null) return null;
      return _userFactory(user, _getProviderLogin(user.providerData));
    } on FirebaseAuthException catch (e, st) {
      throw checkFirebaseAuthError(e.code, exc: e, stackTrace: st);
    }
  }

  @override
  Future<void> recoveryPassword(String email) {
    return firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<LoggedUser?> verifySmsCode(PhoneCredentials phoneCredentials) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: phoneCredentials.id,
        smsCode: phoneCredentials.smsCode,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user!;

      return _userFactory(
        user,
        _getProviderLogin(user.providerData),
      );
    } catch (e, st) {
      throw PhoneLoginError(
          message: 'Datasource error', mainException: e, stacktrace: st);
    }
  }

  @override
  Future<LoggedUser?> loginWithPhone(PhoneAuthCredentials credentials) async {
    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: credentials.phone,
        verificationCompleted: (credential) async {
          final userCredential =
              await firebaseAuth.signInWithCredential(credential);

          final user = userCredential.user!;

          final loggerUser = await _userFactory(
            user,
            _getProviderLogin(user.providerData),
          );
          credentials.onVerified(loggerUser);
        },
        verificationFailed: (error) {
          credentials.onError(PhoneLoginError(
              message: 'Datasource error',
              mainException: error,
              stacktrace: error.stackTrace));
        },
        codeSent: (verificationId, forceResendingToken) {
          credentials.onCode(verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );

      if (kIsWeb) {
        final confirmation =
            await firebaseAuth.signInWithPhoneNumber(credentials.phone);
        credentials.onCode.call(confirmation.verificationId);
      }
      return null;
    } catch (e, st) {
      throw PhoneLoginError(
        message: 'Datasource error',
        mainException: e,
        stacktrace: st,
      );
    }
  }
}
