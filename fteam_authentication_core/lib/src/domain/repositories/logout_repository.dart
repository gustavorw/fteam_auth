import 'package:dartz/dartz.dart';
import '../errors/errors.dart';

/// Interface of [LogoutRepository]
abstract class LogoutRepository {
  ///
  Future<Either<LogoutFailure, Unit>> logout();
}
