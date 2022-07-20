import 'package:fteam_authentication_core/fteam_authentication_core.dart';

AuthFailure checkFirebaseAuthError(
  String code, {
  Object? exc,
  StackTrace? stackTrace,
}) {
  switch (code) {
    case 'user-not-found':
      return EmailLoginError(
        message: 'No user found for that email',
        mainException: exc,
        stacktrace: stackTrace,
      );
    case 'wrong-password':
      return EmailLoginError(
        message: 'Wrong password provided for that user.',
        mainException: exc,
        stacktrace: stackTrace,
      );
    case 'invalid-email':
      return EmailLoginError(
        message: 'The email address is badly formatted.',
        mainException: exc,
        stacktrace: stackTrace,
      );
    case 'weak-password':
      return EmailLoginError(
        message: 'The password provided is too weak.',
        mainException: exc,
        stacktrace: stackTrace,
      );
    case 'email-already-in-use':
      return EmailLoginError(
        message: 'The account already exists for that email.',
        mainException: exc,
        stacktrace: stackTrace,
      );
    case 'credential-already-in-use':
      return DuplicatedAccountProviderError(
        message: 'firebaseDatasource.ErrorCredentialsMessage',
        mainException: exc,
        stacktrace: stackTrace,
      );
    case 'requires-recent-login':
      return DeleteAccountError(
          message: 'firebaseDatasource.requiresRecentLogin',
          mainException: exc,
          stacktrace: stackTrace);
    default:
      return EmailLoginError(
        message: 'Datasource error',
        stacktrace: stackTrace,
        mainException: exc,
      );
  }
}
