







import '../helper/picker.dart';
import '../helper/counter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Store extends StatefulWidget {


  final List coins;
  const Store({ Key? key , required this.coins}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {


  late final Future dataLoaded = initStorage();

  late Map<String,int> storage = {};
  late String selected;


  @override
  void initState() {
    super.initState();  
    selected = widget.coins[1];

  }

  void chooseCoin(int coinIndex){
      setState(() {
        selected = widget.coins[coinIndex];
      });
  }

  void update(bool increase){

    if(!increase && storage[selected] == 0){
      return;
    }
    setState(() {
      storage[selected] = storage[selected]! + (increase ? 1 : -1); 
    });
      
  }

  void save(var docid){
      print(docid);
      FirebaseFirestore.instance
      .collection('user_coins')
      .doc(docid)
      .update(
        {'coin_amount': storage[selected]})
      .then((value) => print('updated'))
      .catchError((error) => print(error));

  }
  void getId() async {
      
      var allRows = await FirebaseFirestore.instance
        .collection('user_coins')
        .where('uuid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('coin_name',isEqualTo: selected)
        .get();
        
        for(var row in allRows.docs){
          save(row.id);
        }
  }
  
  Future<String> initStorage() async{

    
    final query = FirebaseFirestore.instance
    .collection('user_coins')
    .where('uuid',isEqualTo: FirebaseAuth.instance.currentUser!.uid);
    
    final allRows = await query.get();

    for(var row in allRows.docs){

      var data = row.data();
      
      storage[data["coin_name"]] = data["coin_amount"];
     
    }
    return 'data loaded';
  }

  


  @override
  
  Widget build(BuildContext context) {

    return FutureBuilder(
              future: dataLoaded,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      const Text('Store your coins here'),
                      Picker(coinSetter: chooseCoin, coinsNames: widget.coins),
                      Counter(updater: update),
                      Text('${storage[selected]} , $selected'),
                      ElevatedButton(onPressed: getId, child: const Text('Save')),
                    ]
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }
    );
  }
}