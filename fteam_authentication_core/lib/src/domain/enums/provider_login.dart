/// Enum ProviderLogin
/// values (google, facebook, appleId).
enum ProviderLogin {
  /// Google.
  google(name: 'google.com'),

  /// Facebook.
  facebook(name: 'facebook.com'),

  /// Apple
  appleId(name: 'apple.com'),

  /// Email
  emailSignin(name: 'email');

  /// Provider login name.
  final String name;

  /// Provider
  const ProviderLogin({this.name = ''});
}
