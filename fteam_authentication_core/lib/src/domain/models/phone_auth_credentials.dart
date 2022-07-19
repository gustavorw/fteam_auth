import 'package:fteam_authentication_core/fteam_authentication_core.dart';

class PhoneAuthCredentials {
  final String phone;
  final void Function(String verificationId) onCode;
  final void Function(LoggedUser user) onVerified;
  final void Function(AuthFailure error) onError;

  PhoneAuthCredentials({
    required this.phone,
    required this.onCode,
    required this.onVerified,
    required this.onError,
  });
}
