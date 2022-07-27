/// Base exception.
abstract class AuthFailure implements Exception {
  ///
  final String? message;

  ///
  final dynamic stacktrace;

  ///
  final Object? mainException;

  ///
  const AuthFailure({
    this.message,
    required this.stacktrace,
    this.mainException,
  });

  ///
  dynamic copyWith(
      {String? message, dynamic stacktrace, Object? mainException});
}

///
class SocialProviderDontExist extends AuthFailure {
  ///
  const SocialProviderDontExist(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);

  @override
  SocialProviderDontExist copyWith(
      {String? message, stacktrace, Object? mainException}) {
    return SocialProviderDontExist(
      message: message ?? this.message,
      stacktrace: stacktrace ?? this.stacktrace,
      mainException: mainException ?? this.mainException,
    );
  }
}

///
class LogoutFailure implements AuthFailure {
  final String message;
  final dynamic stacktrace;
  final Object? mainException;

  ///
  const LogoutFailure(
      {required this.message,
      required this.stacktrace,
      required this.mainException});

  LogoutFailure copyWith({
    String? message,
    dynamic stacktrace,
    Object? mainException,
  }) {
    return LogoutFailure(
      message: message ?? this.message,
      stacktrace: stacktrace ?? this.stacktrace,
      mainException: mainException ?? this.mainException,
    );
  }
}

///
class CredentialsError extends AuthFailure {
  ///
  const CredentialsError(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);

  @override
  CredentialsError copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      CredentialsError(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}

///
class EmailLoginError extends AuthFailure {
  ///
  const EmailLoginError(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);
  @override
  EmailLoginError copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      EmailLoginError(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}

///
class DuplicatedAccountProviderError extends AuthFailure {
  ///
  const DuplicatedAccountProviderError(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);
  @override
  DuplicatedAccountProviderError copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      DuplicatedAccountProviderError(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}

///
class GoogleLoginError extends AuthFailure {
  ///
  const GoogleLoginError(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);
  @override
  GoogleLoginError copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      GoogleLoginError(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}

///
class AppleIdLoginError extends AuthFailure {
  ///
  const AppleIdLoginError(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);
  @override
  AppleIdLoginError copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      AppleIdLoginError(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}

///
class FacebookLoginError extends AuthFailure {
  ///
  const FacebookLoginError(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);
  @override
  FacebookLoginError copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      FacebookLoginError(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}

///
class PhoneLoginError extends AuthFailure {
  ///
  const PhoneLoginError(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);
  @override
  FacebookLoginError copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      FacebookLoginError(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}

///
class NotUserLogged extends AuthFailure {
  ///
  const NotUserLogged(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);
  @override
  NotUserLogged copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      NotUserLogged(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}

///
class LinkAccountError extends AuthFailure {
  ///
  const LinkAccountError(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);
  @override
  LinkAccountError copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      LinkAccountError(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}

///
class DeleteAccountError extends AuthFailure {
  ///
  const DeleteAccountError(
      {String? message, dynamic stacktrace, Object? mainException})
      : super(
            message: message,
            mainException: mainException,
            stacktrace: stacktrace);
  @override
  DeleteAccountError copyWith(
          {String? message, stacktrace, Object? mainException}) =>
      DeleteAccountError(
        message: message ?? this.message,
        stacktrace: stacktrace ?? this.stacktrace,
        mainException: mainException ?? this.mainException,
      );
}
