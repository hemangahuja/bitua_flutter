import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget {
  final Function setVal;
  const Input({Key? key, required this.setVal}) : super(key: key);

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  final myController = TextEditingController(text: '0');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: TextFormField(
              controller: myController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          ElevatedButton(
              onPressed: pressed,
              child: const Text('okay'))
        ],
      );
    
  }
  void pressed(){
    widget.setVal(int.parse(myController.text));
  }
}