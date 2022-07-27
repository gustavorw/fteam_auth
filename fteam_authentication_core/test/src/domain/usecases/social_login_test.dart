import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fteam_authentication_core/fteam_authentication_core.dart';
import 'package:fteam_authentication_core/src/domain/repositories/auth_repository.dart';
import 'package:fteam_authentication_core/src/domain/usecases/social_login.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late AuthRepository repository;
  late SocialLogin socialLogin;
  setUpAll(() {
    repository = LoginRepositoryMock();
    socialLogin = SocialLoginImpl(repository: repository);
  });

  test(
    'login with facebook success',
    () async {
      final user = LoggedUser(
        uid: '',
        token: '',
        providers: [ProviderLogin.facebook],
      );
      when(() => repository.facebookLogin())
          .thenAnswer((_) async => Right(user));
      final response = await socialLogin.call(provider: ProviderLogin.facebook);
      expect(response.fold(id, id), isA<LoggedUser>());
    },
  );
  test(
    'login with google success',
    () async {
      final user = LoggedUser(
        uid: '',
        token: '',
        providers: [ProviderLogin.google],
      );
      when(() => repository.googleLogin()).thenAnswer((_) async => Right(user));
      final response = await socialLogin.call(provider: ProviderLogin.google);
      expect(response.fold(id, id), isA<LoggedUser>());
      verify(() => repository.googleLogin()).called(1);
    },
  );

  test(
    'login with apple success',
    () async {
      final user = LoggedUser(
        uid: '',
        token: '',
        providers: [ProviderLogin.appleId],
      );
      when(() => repository.appleIdLogin())
          .thenAnswer((_) async => Right(user));
      final response = await socialLogin.call(provider: ProviderLogin.appleId);
      expect(response.fold(id, id), isA<LoggedUser>());
      verify(() => repository.appleIdLogin()).called(1);
    },
  );

  test(
    'should return an SocialProviderDontExist',
    () async {
      final response = await socialLogin(provider: ProviderLogin.emailSignin);
      expect(response.fold(id, id), isA<SocialProviderDontExist>());
    },
  );
}
