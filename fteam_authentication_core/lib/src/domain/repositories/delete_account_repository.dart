import 'package:dartz/dartz.dart';
import '../errors/errors.dart';

/// Interface of [DeleteAccountRepository]
abstract class DeleteAccountRepository {
  ///
  Future<Either<AuthFailure, Unit>> delete();
}
