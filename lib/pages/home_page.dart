// lib/pages/home_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loggin_bloc/blocs/authentication/authentication.dart';
import 'package:loggin_bloc/models/models.dart';

class HomePage extends StatelessWidget {

  final User user;

  const HomePage({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authBloc = BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Bienvenido, ${user.name}',
                style: TextStyle(
                  fontSize: 24
                ),
              ),

              const SizedBox(height: 12),

              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text('Salir'),
                onPressed: (){
                  // Agrega UserLoggedOut al flujo de evento de authentication
                  authBloc.add(UserLoggedOut());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}