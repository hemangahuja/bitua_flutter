import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'converter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List coins = ["bitcoin" , "ethereum"];
  String query = '';
  
  @override
  void initState(){
    super.initState();
    for(int i = 0; i < coins.length;i++){
      query += "${coins[i]},";
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
        ),
        body: Center(
          child: FutureBuilder(
              future: getData(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Converter(prices: jsonDecode(snapshot.data)),
                      
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
