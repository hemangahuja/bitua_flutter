import 'package:flutter/material.dart';

class Counter extends StatelessWidget {

  final Function updater;
  const Counter({ Key? key , required this.updater}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       IconButton(onPressed: ()=>updater(true), icon: const Icon(Icons.add)),
       IconButton(onPressed: ()=>updater(false), icon: const Icon(Icons.remove))
      ],
    );
  }
}