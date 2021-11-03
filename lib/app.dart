import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'converter.dart';
import 'dart:convert';
import 'store.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _auth = FirebaseAuth.instance;
  late User? user;
  
 

  List coins = ["bitcoin" , "ethereum"];
  String query = '';
  
  @override
  void initState(){
    super.initState();
    for(int i = 0; i < coins.length;i++){
      query += "${coins[i]},";
    }

    user = _auth.currentUser;
    if(user != null){
      
    }
  }
  

  Future getData() async {
    var data =
        await http.get(Uri.parse("https://api.coingecko.com/api/v3/simple/price?ids=$query&vs_currencies=inr"));
    return data.body;
  }

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitua',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bitua'),
          actions: [
            IconButton(onPressed: (){
              _auth.signOut();
              Navigator.popAndPushNamed(context, '/'); 
            }, icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Converter(prices: jsonDecode(snapshot.data)),
                      Store(coins : jsonDecode(snapshot.data).keys.toList()),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
} 
