import 'package:bitua/helper/input.dart';
import 'package:bitua/screens/image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helper/picker.dart';
import 'package:intl/intl.dart';


class Converter extends StatefulWidget {

  
  final Map<String,dynamic> prices;
  const Converter({ Key? key ,required this.prices}) : super(key: key);

  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {

  
  Map<String,Image> images = {};

  final f = NumberFormat("###,###.0#","en_US");
  late List coins;
  late String selectedCoin;
  late double multiplier;
  
  @override
  void initState(){
    super.initState();
    coins = widget.prices.keys.toList();
    selectedCoin = coins[0];
    multiplier = 0.0;
  }



  
  void setSelectedCoin(int chosenCoin){
    setState(() {
      selectedCoin = coins[chosenCoin];
      
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
          
          const Text('Check price in INR!'),
          
          Picker(coinsNames : coins , coinSetter : setSelectedCoin),
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
              Flexible(child: Text('${f.format(widget.prices[selectedCoin]["inr"])} ₹ * $multiplier ${selectedCoin[0].toUpperCase()}${selectedCoin.substring(1)} coin(s) = ${f.format(widget.prices[selectedCoin]["inr"] * multiplier)} ₹'))
            ],
          ),
          
      ],),
    )
     ;

  }
}