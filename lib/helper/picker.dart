import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Picker extends StatefulWidget {

  final List coinsNames;
  final Function coinSetter;
  final String identifier;
  const Picker({ Key? key , required this.coinsNames , required this.coinSetter , required this.identifier}): super(key: key);

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {

  int selected = 0;
  List<Widget> coinsWidgets = [];

  @override
  void initState(){
    super.initState();
    for(int i = 0;i < widget.coinsNames.length; i++){
      coinsWidgets.add(Text('${widget.coinsNames[i]}' , style: const TextStyle(color: Colors.lightBlueAccent)));
    }
  }
  
  
  void showPicker(BuildContext context) {
    showCupertinoModalPopup(context: context,
    semanticsDismissible: true,
     builder: (_) => SizedBox(
       
       width: 300,
       height: 200,
       child: CupertinoTheme(
         data: const CupertinoThemeData(
           textTheme: CupertinoTextThemeData(
             pickerTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.deepPurple)
           )
         ),
         child: CupertinoPicker(
           scrollController: FixedExtentScrollController(initialItem: selected),
           
           itemExtent: 30,
           children: coinsWidgets,
           onSelectedItemChanged: (value){
             widget.coinSetter(value);
             setState(() {
               selected = value;
             });
           },
         ),
       ),
     )
     );
  }
  @override 
  Widget build(BuildContext context){
    return CupertinoButton(child: Text('Select ${widget.identifier}'), onPressed: ()=>showPicker(context));
  }
}