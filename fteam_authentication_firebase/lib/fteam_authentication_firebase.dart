library fteam_authentication_firebase;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fteam_authentication_core/fteam_authentication_core.dart';
import 'src/firebase_datasource.dart';
import 'src/providers/provider_options.dart';
import 'src/providers/provider_service.dart';
export 'package:fteam_authentication_core/fteam_authentication_core.dart';
export 'src/providers/provider_options.dart';

bool _isInitialized = false;

/// Invoke the function before runAPP(App()).
void startFirebaseDatasource(ProviderOptions options) {
  if (!_isInitialized) {
    final provider = ProviderService(options);
    final datasource = FirebaseDatasource(
        provider: provider, firebaseAuth: FirebaseAuth.instance);
    FTeamAuth.registerAuthDatasource(datasource);
    _isInitialized = true;
  }
}
