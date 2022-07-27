import 'package:dartz/dartz.dart';
import 'package:fteam_authentication_core/src/domain/entities/phone_auth_credentials.dart';
import 'package:fteam_authentication_core/src/domain/entities/phone_credentials.dart';
import '../entities/logged_user.dart';
import '../errors/errors.dart';
import '../entities/email_credencials.dart';

/// Interface of AuthRepository
abstract class AuthRepository {
  ///
  Future<Either<AuthFailure, LoggedUser?>> googleLogin();

  ///
  Future<Either<AuthFailure, LoggedUser?>> appleIdLogin();

  ///
  Future<Either<AuthFailure, LoggedUser?>> facebookLogin();

  ///
  Future<Either<AuthFailure, Unit>> sendEmailVerification();

  ///
  Future<Either<AuthFailure, Unit>> recoveryPassword(String email);

  ///
  Future<Either<AuthFailure, LoggedUser?>> emailLogin(
    EmailCredencials emailCredencials,
  );

  ///
  Future<Either<AuthFailure, LoggedUser?>> phoneLogin(
    PhoneAuthCredentials phoneAuthCredencials,
  );

  ///
  Future<Either<AuthFailure, LoggedUser?>> verifySmsCode(
    PhoneCredentials phoneCredentials,
  );
}
