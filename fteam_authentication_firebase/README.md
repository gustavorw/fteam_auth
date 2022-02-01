# fteam_authentication_firebase

IATec' Datasource Authentication using Firebase

## Install

Add in your pubspec.yaml
```yaml
dependencies:
  fteam_authentication_core:
    hosted:
      name: fteam_authentication_firebase
      url: http://165.22.8.0:8080
    version: 0.0.7
    
  fteam_authentication_firebase:
    hosted:
      name: fteam_authentication_firebase
      url: http://165.22.8.0:8080
    version: 0.0.7

```



## Usage

Configure natives:
[firebase_core](https://pub.dev/packages/firebase_core)
[firebase_auth](https://pub.dev/packages/firebase_auth)
[google_sign_in](https://pub.dev/packages/google_sign_in)
[flutter_facebook_auth](https://pub.dev/packages/flutter_facebook_auth)
[sign_in_with_apple](https://pub.dev/packages/sign_in_with_apple)

```dart

main(){


  //IMPORTANT iOS Auth Users
  startFirebaseDatasource(ProviderOptions(
      appleClientId: 'br.com.example', 
      appleRedirectUri: 'https://...',
    ),
  );
  ...
}

```