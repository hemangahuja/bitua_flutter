import 'package:bitua/app.dart';
import 'package:bitua/login.dart';
import 'register.dart';
import 'package:flutter/material.dart';

class RouteHandler extends StatelessWidget {
  const RouteHandler({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitua',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/main':(context) => const MyApp(),
        '/register':(context) => const RegisterScreen(),
      },
    );
  }
}