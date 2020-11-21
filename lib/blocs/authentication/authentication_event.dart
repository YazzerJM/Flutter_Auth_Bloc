// lib/blocs/authentication/authentication_event.dart
import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';
import '../../models/models.dart';

abstract class AuthenticationEvent extends Equatable{
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

// Se activa justo despues de que se lanza la aplicacion
class AppLoaded extends AuthenticationEvent{}

// Se activa cuando el usuario ha iniciado sesion correctamente
class UserLoggedIn extends AuthenticationEvent{

  final User user;
  
  UserLoggedIn({@required this.user});

  @override
  List<Object> get props => [user];
}

// Se activa cuando el usuario se desconecta
class UserLoggedOut extends AuthenticationEvent{}