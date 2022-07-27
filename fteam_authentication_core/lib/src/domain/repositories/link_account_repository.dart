import 'package:dartz/dartz.dart';
import '../entities/logged_user.dart';
import '../enums/provider_login.dart';
import '../errors/errors.dart';

/// Interface of [LinkAccountRepository]
abstract class LinkAccountRepository {
  ///
  Future<Either<AuthFailure, LoggedUser?>> linkAccount(ProviderLogin provider);

  ///
  Future<Either<AuthFailure, LoggedUser?>> unlinkAccount(
      ProviderLogin provider);
}
