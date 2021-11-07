
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screens/converter.dart';
import 'dart:convert';
import 'screens/store.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatefulWidget {

  final List<String> coins;
  const MyApp({Key? key , required this.coins}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final _auth = FirebaseAuth.instance;
  late User? user;
  
 

  
  String query = '';
  
  @override
  void initState(){
    super.initState();
    for(int i = 0; i < widget.coins.length;i++){
      query += "${widget.coins[i]},";
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
        
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(width: 50,),
              Text('Bitua' , style: TextStyle(color: Colors.black ),),
            ],
          )),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.yellow[600]!, Colors.red[200]!]),
              )
            ),
          actions: [
            IconButton(onPressed: (){
              _auth.signOut();
              Navigator.popAndPushNamed(context, '/'); 
            }, icon: const Icon(Icons.logout , color: Colors.black,))
          ],
        ),
        body: Container(
          decoration:  BoxDecoration(
           color: Colors.grey[850],
          ),
        
          child: Center(
            child: FutureBuilder(
                future: getData(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Converter(prices: jsonDecode(snapshot.data)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Store(coins : jsonDecode(snapshot.data).keys.toList()),
                        ),
                      ],
                    );
                  }
                  if(snapshot.hasError){
                            
                       return const Text('error');
                  }   
                  else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ),
    );
  }
} 
