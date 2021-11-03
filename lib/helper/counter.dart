import 'package:flutter/material.dart';

class Counter extends StatelessWidget {

  final Function updater;
  const Counter({ Key? key , required this.updater}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       ElevatedButton(onPressed: ()=>updater(true), child: const  Text('add')),
       ElevatedButton(onPressed: ()=>updater(false), child: const Text('sub'))
      ],
    );
  }
}