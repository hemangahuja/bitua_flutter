import 'dart:collection';

import 'package:bitua/helper/input.dart';
import 'package:bitua/screens/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helper/picker.dart';
import 'package:intl/intl.dart';


class Converter extends StatefulWidget {

  
  final SplayTreeMap<String,dynamic> prices;
  final Map<String,String> fiatSymbols;
  const Converter({ Key? key ,required this.prices , required this.fiatSymbols}) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {

  

  final f = NumberFormat("###,###.0#","en_US");
  late List coins;
  late List fiats;
  late String selectedCoin;
  late String selectedFiat;
  late double multiplier;
  
  @override
  void initState(){
    super.initState();
    coins = widget.prices.keys.toList();
    selectedCoin = coins[0];
    fiats = widget.fiatSymbols.keys.toList();
    selectedFiat = fiats[0];
    multiplier = 0.0;   
  }



  
  void setSelectedCoin(int chosenCoin){
    setState(() {
      selectedCoin = coins[chosenCoin];
      
    });
  }
  void setSelectedFiat(int chosenFiat){
    setState(() {
      selectedFiat = fiats[chosenFiat];
    });
  }
  void setMultiplier(double val){
    setState(() {
      multiplier = val;
    });
  }



  @override
  Widget build(BuildContext context) {


    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        
        gradient: LinearGradient(colors: [Colors.yellow[600]! ,Colors.red[200]!]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [
          
          Picker(coinsNames: fiats.map((e) => e.toUpperCase()).toList(), coinSetter: setSelectedFiat , identifier: "Fiat",),

          Text('Check Price in ${selectedFiat.toUpperCase()}!'),
          
          Picker(coinsNames : coins , coinSetter : setSelectedCoin , identifier: "Coin",),
          SizedBox(
            height: 50,
            width: 50,
            child: ImageLoader(coin: selectedCoin,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Input(setVal: setMultiplier),
              const SizedBox(width: 10,),
              Flexible(child: Text(
              '$multiplier ${selectedCoin[0].toUpperCase()}${selectedCoin.substring(1)} coin(s) in ${selectedFiat.toUpperCase()} are ' 
              '${multiplier * widget.prices[selectedCoin][selectedFiat]}'
              '${widget.fiatSymbols[selectedFiat]}'
              ))
            ],
          ),
          
      ],),
    )
     ;

  }
}