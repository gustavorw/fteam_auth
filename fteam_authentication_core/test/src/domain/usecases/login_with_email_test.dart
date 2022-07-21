import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fteam_authentication_core/fteam_authentication_core.dart';
import 'package:fteam_authentication_core/src/domain/repositories/auth_repository.dart';
import 'package:fteam_authentication_core/src/domain/usecases/login_with_email.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late AuthRepository repository;
  late LoginWithEmail loginEmail;
  setUpAll(() {
    repository = LoginRepositoryMock();
    loginEmail = LoginWithEmailImpl(repository: repository);
  });

  test(
    'should do login with Email provider',
    () async {
      final emailCredencials =
          EmailCredencials(email: 'test@email.com', password: 'pass123');
      final user = LoggedUser(
        uid: '',
        token: '',
        providers: [ProviderLogin.emailSignin],
      );
      when(() => repository.emailLogin(emailCredencials)).thenAnswer(
        (_) async => Right(user),
      );
      final response = await loginEmail(emailCredencials: emailCredencials);
      expect(
        response.fold(id, id),
        isA<LoggedUser>(),
      );
      verify(() => repository.emailLogin(emailCredencials)).called(1);
    },
  );
  test(
    'should return an EmailLoginError',
    () async {
      final emailCredencials =
          EmailCredencials(email: 'test@email.com', password: 'pass123');
      when(() => repository.emailLogin(emailCredencials)).thenAnswer(
        (_) async => Left(EmailLoginError()),
      );
      final response = await loginEmail(emailCredencials: emailCredencials);
      expect(
        response.fold(id, id),
        isA<EmailLoginError>(),
      );
      verify(() => repository.emailLogin(emailCredencials)).called(1);
    },
  );
}
