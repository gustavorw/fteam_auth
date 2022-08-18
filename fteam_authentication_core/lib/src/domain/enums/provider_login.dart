/// Enum ProviderLogin
/// values (google, facebook, appleId).
enum ProviderLogin {
  /// Google.
  google(provider: 'google.com'),

  /// Facebook.
  facebook(provider: 'facebook.com'),

  /// Apple
  appleId(provider: 'apple.com'),

  /// Phone
  phone(provider: 'phone'),

  /// Email
  emailSignin(provider: 'email');

  /// Provider name
  final String provider;

  /// Constructor for default is email
  const ProviderLogin({this.provider = 'email'});
}
