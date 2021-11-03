import 'package:bitua/app.dart';
import 'package:bitua/screens/login.dart';
import '../screens/register.dart';
import 'package:flutter/material.dart';

class RouteHandler extends StatelessWidget {

  RouteHandler({ Key? key }) : super(key: key);

  final List coins = ["bitcoin" , "ethereum"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitua',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/main':(context) => MyApp(coins: coins),
        '/register':(context) => RegisterScreen(coins : coins),
      },
    );
  }
}