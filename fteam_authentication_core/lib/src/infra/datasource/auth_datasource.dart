import 'dart:async';
import 'package:fteam_authentication_core/src/domain/entities/phone_auth_credentials.dart';
import 'package:fteam_authentication_core/src/domain/entities/phone_credentials.dart';
import '../../domain/entities/logged_user.dart';
import '../../domain/entities/email_credencials.dart';
import '../../domain/enums/provider_login.dart';

/// Implement this interface in your datasource.
/// And register your instance [FTeamAuth.registerAuthDatasource].
abstract class AuthDatasource {
  ///
  Future<LoggedUser?> loginWithGoogle();

  ///
  Future<LoggedUser?> loginWithFacebook();

  ///
  Future<LoggedUser?> loginWithAppleId();

  ///
  Future<LoggedUser?> loginWithEmail(EmailCredencials credencials);

  ///
  Future<LoggedUser?> signupWithEmail(EmailCredencials credencials);

  ///
  Future<LoggedUser?> loginWithPhone(PhoneAuthCredentials credencials);

  ///
  Future<LoggedUser?> verifySmsCode(PhoneCredentials credentials);

  ///
  Future<int> logout();

  ///
  Future<void> deleteAccount();

  ///
  Future<void> sendEmailVerification();

  ///
  Future<void> recoveryPassword(String email);

  ///
  Future<LoggedUser?> getLoggedUser();

  ///
  FutureOr<LoggedUser?> linkAccount(ProviderLogin provider);

  ///
  Future<LoggedUser?> unlinkAccount(ProviderLogin provider);
}
