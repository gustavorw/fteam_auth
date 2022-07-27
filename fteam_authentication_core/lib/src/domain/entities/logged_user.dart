import '../enums/provider_login.dart';

/// Entity
class LoggedUser {
  ///
  final String name;

  ///
  final String email;

  ///
  final String uid;

  ///
  final String urlPhoto;

  ///
  final String token;

  ///
  final bool emailVerified;

  ///
  final String phone;

  ///
  final List<ProviderLogin> providers;

  ///
  const LoggedUser({
    required this.uid,
    required this.token,
    required this.providers,
    this.name = '',
    this.email = '',
    this.urlPhoto = '',
    this.emailVerified = false,
    this.phone = '',
  });

  ///
  LoggedUser copyWith({
    required String uid,
    required String token,
    required List<ProviderLogin> providers,
    String? name,
    String? email,
    String? urlPhoto,
    bool? emailVerified,
    String? phone,
  }) {
    return LoggedUser(
      uid: uid,
      token: token,
      name: name ?? this.name,
      email: email ?? this.email,
      urlPhoto: urlPhoto ?? this.urlPhoto,
      emailVerified: emailVerified ?? this.emailVerified,
      providers: providers,
      phone: phone ?? this.phone,
    );
  }
}
