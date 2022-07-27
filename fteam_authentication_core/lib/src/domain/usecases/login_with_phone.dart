import 'package:dartz/dartz.dart';
import '../../../fteam_authentication_core.dart';
import '../repositories/auth_repository.dart';

///
abstract class LoginWithPhone {
  ///
  Future<Either<AuthFailure, LoggedUser?>> call(
      {required PhoneAuthCredentials phoneCredencials});
}

///
class LoginWithPhoneImpl implements LoginWithPhone {
  ///
  final AuthRepository repository;

  ///
  LoginWithPhoneImpl({required this.repository});
  @override
  Future<Either<AuthFailure, LoggedUser?>> call(
      {required PhoneAuthCredentials phoneCredencials}) async {
    return await repository.phoneLogin(phoneCredencials);
  }
}
