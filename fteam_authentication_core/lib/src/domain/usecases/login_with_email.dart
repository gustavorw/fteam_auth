import 'dart:async';
import 'package:dartz/dartz.dart';
import '../entities/logged_user.dart';
import '../errors/errors.dart';
import '../entities/email_credencials.dart';
import '../repositories/auth_repository.dart';

///
abstract class LoginWithEmail {
  ///
  Future<Either<AuthFailure, LoggedUser?>> call({
    required EmailCredencials emailCredencials,
  });
}

///
class LoginWithEmailImpl implements LoginWithEmail {
  ///
  final AuthRepository repository;

  ///
  const LoginWithEmailImpl({required this.repository});

  @override
  Future<Either<AuthFailure, LoggedUser?>> call(
      {required EmailCredencials emailCredencials}) async {
    return await repository.emailLogin(emailCredencials);
  }
}
