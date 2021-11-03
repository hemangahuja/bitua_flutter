
import 'dart:convert';
import 'picker.dart';
import 'counter.dart';

import 'package:flutter/material.dart';

class Store extends StatefulWidget {

  final List coins;
  const Store({ Key? key , required this.coins}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {

  late Map<String,int> storage = {};
  late String selected;

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
  @override
  void initState(){
    super.initState();
    for(int i = 0; i < widget.coins.length; i++){
      storage[widget.coins[i]] = 0;
    }
    selected = widget.coins[0];
  }
  @override
  
  Widget build(BuildContext context) {
    return Column(
      children: [

        Picker(coinSetter: chooseCoin, coinsNames: widget.coins),
        Counter(updater: update),
        Text('${storage[selected]} , $selected'),
        
      ]
    );
  }
}