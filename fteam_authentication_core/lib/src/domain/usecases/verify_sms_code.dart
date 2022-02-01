import 'package:dartz/dartz.dart';
import 'package:fteam_authentication_core/src/domain/errors/errors.dart';
import 'package:fteam_authentication_core/src/domain/models/phone_model.dart';
import 'package:fteam_authentication_core/src/domain/repositories/auth_repository.dart';

import '../../../fteam_authentication_core.dart';

abstract class VerifySmsCode {
  Future<Either<AuthFailure, LoggedUser?>> call(PhoneModel phone);
}

class VerifySmsCodeImp implements VerifySmsCode {
  final AuthRepository repository;

  VerifySmsCodeImp({required this.repository});

  @override
  Future<Either<AuthFailure, LoggedUser?>> call(PhoneModel phone) async {
    assert(phone.smsCode.isNotEmpty, 'Sms Code not be empty.');
    assert(phone.phone.isNotEmpty, 'Phone not be empty');
    return await repository.verifySmsCode(phone);
  }
}
