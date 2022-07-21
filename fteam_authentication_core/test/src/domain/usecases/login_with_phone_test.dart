import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fteam_authentication_core/fteam_authentication_core.dart';
import 'package:fteam_authentication_core/src/domain/repositories/auth_repository.dart';
import 'package:fteam_authentication_core/src/domain/usecases/login_with_email.dart';
import 'package:fteam_authentication_core/src/domain/usecases/login_with_phone.dart';
import 'package:mocktail/mocktail.dart';

class LoginRepositoryMock extends Mock implements AuthRepository {}

void main() {
  late AuthRepository repository;
  late LoginWithPhone loginWithPhone;
  setUpAll(
    () {
      repository = LoginRepositoryMock();
      loginWithPhone = LoginWithPhoneImpl(repository: repository);
    },
  );

  test(
    'login with phone success',
    () async {
      final user = LoggedUser(
        uid: '',
        token: '',
        providers: [ProviderLogin.emailSignin],
      );
      final phoneAuthCredentials = PhoneAuthCredentials(
        onCode: (_) {},
        onError: (_) {},
        onVerified: (_) {},
        phone: '0000000',
      );
      when(() => repository.phoneLogin(phoneAuthCredentials))
          .thenAnswer((_) async => Right(user));
      final response =
          await loginWithPhone.call(phoneCredencials: phoneAuthCredentials);
      expect(response.fold(id, id), isA<LoggedUser>());
      verify(() => repository.phoneLogin(phoneAuthCredentials)).called(1);
    },
  );

  test(
    'should return an PhoneLoginError',
    () async {
      final phoneAuthCredentials = PhoneAuthCredentials(
        onCode: (_) {},
        onError: (_) {},
        onVerified: (_) {},
        phone: '0000000',
      );
      when(() => repository.phoneLogin(phoneAuthCredentials))
          .thenAnswer((_) async => Left(PhoneLoginError()));
      final response =
          await loginWithPhone(phoneCredencials: phoneAuthCredentials);
      expect(response.fold(id, id), isA<PhoneLoginError>());
      verify(() => repository.phoneLogin(phoneAuthCredentials)).called(1);
    },
  );
}
