import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final Function setVal;
  const Input({Key? key, required this.setVal}) : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  final myController = TextEditingController(text: '0.0');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
          SizedBox(
            width: 75,
            child: TextFormField(
              textAlign: TextAlign.center,
              onChanged: (val) => pressed(val),
              controller: myController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9.]"))],
            ),  
          );
       
    
  }
  void pressed(val){
    if(val == ''){
      val = '0.0';
    }
    widget.setVal(double.parse(val));
  }
}