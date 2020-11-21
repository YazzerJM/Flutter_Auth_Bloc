


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/pages.dart';
import 'blocs/blocs.dart';
import 'service/services.dart';

void main() => runApp(
  // Inyectamos el servicio de autenticacion
  RepositoryProvider<AuthenticationService>(
    create: (context){
      return FakeAuthenticationService();
    },
    // Inyectamos el BLoC de autenticacion
    child: BlocProvider<AuthenticationBloc>(
      create: (context) {
        final authService = RepositoryProvider.of<AuthenticationService>(context);
        return AuthenticationBloc(authService)..add(AppLoaded());
      },
      child: MyApp(),
    ),
  )
);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muestra de Autenticacion',
      theme: ThemeData(
        primaryColor: Colors.orange[600]
      ),
      // El BlocBuilder escuchara los cambios AuthenticationState y construye el widget apropiado segun el estado
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if(state is AuthenticationAuthenticated){
            return HomePage(user: state.user); // Muestra la pagina de inicio
          }

          return LoginPage();
        },
      )

    );
  }
}