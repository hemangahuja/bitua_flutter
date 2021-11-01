import 'package:bitua/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'picker.dart';

class Converter extends StatefulWidget {

  final Map<String,dynamic> prices;
  const Converter({ Key? key ,required this.prices}) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {

  late List coins;
  late String selectedCoin;
  late int multiplier;
  @override
  void initState(){
    super.initState();
    coins = widget.prices.keys.toList();
    selectedCoin = coins[0];
    multiplier = 0;
  }

  void setSelectedCoin(int chosenCoin){
    setState(() {
      selectedCoin = coins[chosenCoin];
      
    });
  }

  void setMultiplier(int val){
    setState(() {
      multiplier = val;
    });
  }

  @override
  Widget build(BuildContext context) {
  
    return Column(children: [
        Picker(coinsNames : coins , coinSetter : setSelectedCoin),
        Input(setVal: setMultiplier),
        Text('${widget.prices[selectedCoin]["inr"]} * $multiplier = ${widget.prices[selectedCoin]["inr"] * multiplier}')
    ],)
     ;

  }
}