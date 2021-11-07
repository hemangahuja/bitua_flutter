







import 'package:bitua/screens/image.dart';

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
  bool isSaving = false;
  bool isError = false;

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
  
      FirebaseFirestore.instance
      .collection('user_coins')
      .doc(docid)
      .update(
        {'coin_amount': storage[selected]})
      .then((val)=>{});

  } 
  void getId() async {
      
      setState(() {
        isSaving = true;
      });
      var allRows = await FirebaseFirestore.instance
        .collection('user_coins')
        .where('uuid',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('coin_name',isEqualTo: selected)
        .get();
        
        for(var row in allRows.docs){
          save(row.id);
        }
        setState(() {
          isSaving = false;
        });
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
                      SizedBox(height : 50 , width : 50 , child: ImageLoader(coin: selected,)),
                      Counter(updater: update),
                      Text('You have ${storage[selected]} coin(s) of ${selected[0].toUpperCase()}${selected.substring(1)} currency!'),
                      ElevatedButton(onPressed: getId, child: const Text('Save')),
                      isSaving ? const CircularProgressIndicator() : const SizedBox(),
                    ]
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }
    );
  }
}