import '../exceptions/exceptions.dart';

import 'package:loggin_bloc/models/models.dart';

abstract class AuthenticationService {
  Future<User> getCurrentUser();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
}

class FakeAuthenticationService extends AuthenticationService{

  @override
  Future<User> getCurrentUser(){
    return null; // Retorna null por ahora
  }

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(Duration(seconds: 1)); // Simula un retrazo en la red

    if(email.toLowerCase() != 'test@domain.com' || password != 'pass123'){
      throw AuthenticationException(message: 'Usuario o Contraseña incorrecta');
    }

    return User(name: 'Yasser', email: email);
  }

  @override
  Future<void> signOut(){
    return null;
  }
}