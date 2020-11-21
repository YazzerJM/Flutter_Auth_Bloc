// lib/blocs/authentication/authentication_bloc.dart

import 'package:bloc/bloc.dart';

import 'package:loggin_bloc/service/services.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  
  final AuthenticationService _authenticationService;
  
  AuthenticationBloc(AuthenticationService authenticationService)
    : assert(authenticationService != null),
    _authenticationService = authenticationService,
    super(AuthenticationInitial());
  
  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {

    if(event is AppLoad){
      yield* _mapAppLoadedToState(event);
    }
    
    if(event is UserLoggedIn){
      yield* _mapUserLoggedInToState(event);
    }

    if(event is UserLoggedOut){
      yield* _mapUserLoggedOutToState(event);
    }
  }

  Stream<AuthenticationState> _mapAppLoadedToState(AppLoad event) async*{
    yield AuthenticationLoading();
    
    try{
      await Future.delayed(Duration(milliseconds: 500)); // Simulamos una espera
      final currentUser = await _authenticationService.getCurrentUser();

      if(currentUser != null){
        yield AuthenticationAuthenticated(user: currentUser);
      }else{
        yield AuthenticationNotAuthenticated();
      }
    }catch(e){
      yield AuthenticationFailure(message: e.message ?? 'Error en la autenticacion');
    }
  }
  
  Stream<AuthenticationState> _mapUserLoggedInToState(UserLoggedIn event) async* {
    yield AuthenticationAuthenticated(user: event.user);
  }

  Stream<AuthenticationState> _mapUserLoggedOutToState(UserLoggedOut event) async* {

    await _authenticationService.signOut();
    yield AuthenticationNotAuthenticated();
  }

}