import 'package:bitua/app.dart';
import 'package:bitua/screens/login.dart';
import '../screens/register.dart';
import 'package:flutter/material.dart';

class RouteHandler extends StatelessWidget {

  RouteHandler({ Key? key }) : super(key: key);

  
  final List<String> coins = ["bitcoin","ethereum","stellar","basic-attention-token","dogecoin","ripple","bitcoin-cash","filecoin","litecoin","zcash","tether","dash"];
  final Map<String,String> fiatWithSymbols = {
    "inr" : "₹",
    "usd" : "\$",
    "jpy" : "¥",
    "eur" : "€",
    "kwd" : "KD",
    "sar" : "SAR"
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitua',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/main':(context) => MyApp(coins: coins ,fiatSymbols: fiatWithSymbols),
        '/register':(context) => RegisterScreen(coins : coins),
      },
    );
  }
}