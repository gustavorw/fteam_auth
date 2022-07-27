import 'package:dartz/dartz.dart';
import '../entities/logged_user.dart';
import '../errors/errors.dart';
import '../entities/email_credencials.dart';

/// interface of [SignupWithEmailRepository]
abstract class SignupWithEmailRepository {
  ///
  Future<Either<AuthFailure, LoggedUser?>> signup(EmailCredencials credencials);
}
