import 'package:dartz/dartz.dart';

import '../../fteam_authentication_core.dart';

/// Controller interface
abstract class FteamAuthetication {
  ///
  Future<Either<AuthFailure, Unit>> deleteAccount();

  ///
  Future<Either<AuthFailure, LoggedUser?>> getLoggedUser();

  ///
  Future<Either<AuthFailure, LoggedUser?>> linkAccount(ProviderLogin provider);

  ///
  Future<Either<AuthFailure, LoggedUser?>> loginWithEmail(
      {required EmailCredencials emailCredencials});

  ///
  Future<Either<AuthFailure, LoggedUser?>> loginWithPhone(
      {required PhoneAuthCredentials phoneAuthCredentials});

  ///
  Future<Either<AuthFailure, LoggedUser?>> socialLogin(
      {required ProviderLogin provider});

  ///
  Future<Either<LogoutFailure, Unit>> logout();

  ///
  Future<Either<AuthFailure, LoggedUser?>> unLinkAccount(
      ProviderLogin provider);

  ///
  Future<Either<AuthFailure, LoggedUser?>> verifySmsCode(
      PhoneCredentials phoneCredentials);

  ///
  Future<Either<AuthFailure, Unit>> sendEmailVerification();

  ///
  Future<Either<AuthFailure, Unit>> recoveryPassword(String email);

  ///
  Future<Either<AuthFailure, LoggedUser?>> signupWithEmail(
      {required EmailCredencials emailCredencials});

  /// Method where the [AuthDatasource] is registered.
  void registerAuthDatasource(AuthDatasource datasource);

  /// Change current instance and add a new instance.
  void changeRegister<T>(T instance);
}
