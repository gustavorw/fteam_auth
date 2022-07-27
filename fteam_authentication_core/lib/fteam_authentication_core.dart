library fteam_authentication_core;

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:fteam_authentication_core/src/domain/entities/phone_auth_credentials.dart';
import 'package:fteam_authentication_core/src/domain/entities/phone_credentials.dart';
import 'package:fteam_authentication_core/src/domain/usecases/social_login.dart';
import 'package:fteam_authentication_core/src/domain/usecases/verify_sms_code.dart';
import 'src/core_module.dart';
import 'src/domain/entities/logged_user.dart';
import 'src/domain/enums/provider_login.dart';
import 'src/domain/errors/errors.dart';
import 'src/domain/entities/email_credencials.dart';
import 'src/domain/usecases/delete_account.dart';
import 'src/domain/usecases/get_logged_user.dart';
import 'src/domain/usecases/link_account.dart';
import 'src/domain/usecases/login_with_email.dart';
import 'src/domain/usecases/login_with_phone.dart';
import 'src/domain/usecases/logout.dart';
import 'src/domain/usecases/recovery_password.dart';
import 'src/domain/usecases/send_email_verification.dart';
import 'src/domain/usecases/signup_with_email.dart';
import 'src/domain/usecases/unlink_account.dart';
import 'src/infra/datasource/auth_datasource.dart';
import 'src/interfaces/fteam_authetication.dart';
export 'src/domain/entities/logged_user.dart';
export 'src/domain/errors/errors.dart';
export 'src/domain/entities/email_credencials.dart';
export 'src/infra/datasource/auth_datasource.dart';
export 'src/domain/entities/phone_credentials.dart';
export 'src/domain/entities/phone_auth_credentials.dart';
export 'src/domain/enums/provider_login.dart';

/// FteamAuth singleton of all methods
final FTeamAuth = _FteamAutheticationImpl();

class _FteamAutheticationImpl implements FteamAuthetication {
  @override
  Future<Either<AuthFailure, Unit>> deleteAccount() {
    return authModule.resolve<DeleteAccount>()();
  }

  @override
  Future<Either<AuthFailure, LoggedUser?>> getLoggedUser({
    bool Function(String token, Map payload)? checkToken,
    Duration tryAgainTime = const Duration(milliseconds: 800),
  }) {
    return authModule.resolve<GetLoggedUser>().call(
        checkToken: checkToken as bool Function(String, Map<dynamic, dynamic>),
        tryAgainTime: tryAgainTime);
  }

  @override
  Future<Either<AuthFailure, LoggedUser?>> linkAccount(ProviderLogin provider) {
    return authModule.resolve<LinkAccount>()(provider);
  }

  @override
  Future<Either<AuthFailure, LoggedUser?>> loginWithEmail({
    required EmailCredencials emailCredencials,
  }) {
    return authModule.resolve<LoginWithEmail>()(
        emailCredencials: emailCredencials);
  }

  @override
  Future<Either<LogoutFailure, Unit>> logout() {
    return authModule.resolve<Logout>()();
  }

  @override
  Future<Either<AuthFailure, LoggedUser?>> unLinkAccount(
      ProviderLogin provider) {
    return authModule.resolve<UnLinkAccount>()(provider);
  }

  @override
  void registerAuthDatasource(AuthDatasource instance) {
    authModule.registerInstance<AuthDatasource>(instance);
  }

  @visibleForTesting
  @override
  void changeRegister<T>(T instance) {
    authModule.unregister<T>();
    authModule.registerInstance<T>(instance);
  }

  @override
  Future<Either<AuthFailure, Unit>> sendEmailVerification() {
    return authModule.resolve<SendEmailVerification>()();
  }

  @override
  Future<Either<AuthFailure, LoggedUser?>> signupWithEmail(
      {required EmailCredencials emailCredencials}) {
    return authModule.resolve<SignupWithEmail>()(credencials: emailCredencials);
  }

  @override
  Future<Either<AuthFailure, Unit>> recoveryPassword(String email) {
    return authModule.resolve<RecoveryPassword>()(email);
  }

  @override
  Future<Either<AuthFailure, LoggedUser?>> verifySmsCode(
      PhoneCredentials phoneCredentials) {
    return authModule.resolve<VerifySmsCode>().call(phoneCredentials);
  }

  @override
  Future<Either<AuthFailure, LoggedUser?>> loginWithPhone(
      {required PhoneAuthCredentials phoneAuthCredentials}) {
    return authModule
        .resolve<LoginWithPhone>()
        .call(phoneCredencials: phoneAuthCredentials);
  }

  @override
  Future<Either<AuthFailure, LoggedUser?>> socialLogin(
      {required ProviderLogin provider}) {
    return authModule.resolve<SocialLogin>().call(provider: provider);
  }
}
