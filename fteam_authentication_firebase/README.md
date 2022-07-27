# fteam_authentication_firebase

IATec' Datasource Authentication using Firebase

## Install

```
dependencies:
  fteam_authentication_firebase:
```

## Uso
Necessário ter um projeto configurado com o firebase. Caso não tenha ainda seguir os passos na documentação do [firebase](https://firebase.flutter.dev/docs/overview/).

### Métodos Disponíveis 
| Methods              | Return Success| Return Error   |   
|----------------------|---------------|----------------|
| loginWithEmail       | LoggedUser    |  AuthFailure   |  
| logout               | Unit          |  LogoutFailure |  
| getLoggedUser        | LoggedUser    |  AuthFailure   |  
| deleteAccount        | Unit          |  AuthFailure   |  
| linkAccount          | LoggedUser    |  AuthFailure   |  
| sendEmalVerification | Unit          |  AuthFailure   |  
| signupWithEmail      | LoggedUser    |  AuthFailure   |  
| socialLogin          | LoggedUser    |  AuthFailure   |
| loginWithPhone       | LoggedUser    |  AuthFailure   |
### Autenticação Social

Para usar os serviços de autenticação é preciso fazer a confuguração nativa de cada plataforma: 

* [google_sign_in](https://pub.dev/packages/google_sign_in)

* [flutter_facebook_auth](https://pub.dev/packages/flutter_facebook_auth)
* [sign_in_with_apple](https://pub.dev/packages/sign_in_with_apple)

Caso encontre dificuldades para fazer as configurações nativas use os guias abaixo:
- [Setup Google sign in flutter]()
- [Setup Facebook auth in flutter]()
- [Setup sign in with Apple in flutter]()

### Example 
```dart

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //IMPORTANT iOS Auth Users
  startFirebaseDatasource(ProviderOptions(
      appleClientId: 'br.com.example', 
      appleRedirectUri: 'https://...',
    ),
  );
  ...
}

// Example login google.
Future<void> google() async {
    final response =
        await FTeamAuth.socialLogin(provider: ProviderLogin.google);
    response.fold(
      (err) {
        log(err.message!);
      },
      (user) {
        log(user!.email);
      },
    );
  }
```