import 'package:dartz/dartz.dart';
import '../../../fteam_authentication_core.dart';
import '../repositories/auth_repository.dart';

///
abstract class SocialLogin {
  ///
  Future<Either<AuthFailure, LoggedUser?>> call(
      {required ProviderLogin provider});
}

///
class SocialLoginImpl implements SocialLogin {
  ///
  final AuthRepository repository;

  ///
  SocialLoginImpl({required this.repository});
  @override
  Future<Either<AuthFailure, LoggedUser?>> call(
      {required ProviderLogin provider}) async {
    switch (provider) {
      case ProviderLogin.google:
        return await repository.googleLogin();
      case ProviderLogin.appleId:
        return await repository.appleIdLogin();
      case ProviderLogin.facebook:
        return await repository.facebookLogin();
      default:
        return Left(
          SocialProviderDontExist(
            message: 'there is no implementation for this provider: $provider',
            stacktrace: StackTrace.current,
          ),
        );
    }
  }
}
