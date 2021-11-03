import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Picker extends StatefulWidget {

  final List coinsNames;
  final Function coinSetter;
  const Picker({ Key? key , required this.coinsNames , required this.coinSetter }): super(key: key);

  @override
  _PickerState createState() => _PickerState();
}

class _PickerState extends State<Picker> {


  List<Widget> coinsWidgets = [];

  @override
  void initState(){
    super.initState();
    for(int i = 0;i < widget.coinsNames.length; i++){
      coinsWidgets.add(Text('${widget.coinsNames[i]}'));
    }
  }
  
  
  void showPicker(BuildContext context) {
    showCupertinoModalPopup(context: context,
     builder: (_) => SizedBox(
       width: 100,
       height: 200,
       child: CupertinoPicker(
         
         backgroundColor: Colors.grey,
         itemExtent: 30,
         
         scrollController: FixedExtentScrollController(initialItem: 1),
         
         children: coinsWidgets,
         onSelectedItemChanged: (value){
           widget.coinSetter(value);
         },
       ),
     )
     );
  }
  @override 
  Widget build(BuildContext context){
    return CupertinoButton(child: const Text('Select coin'), onPressed: ()=>showPicker(context));
  }
}