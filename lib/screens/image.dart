import 'package:flutter/material.dart';

class ImageLoader extends StatelessWidget {
  final String coin;
  const ImageLoader({ Key? key , required this.coin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: 'images/placeholder_pepe.jpg', 
      image: 'https://raw.githubusercontent.com/condacore/cryptocurrency-icons/master/64x64/$coin.png'
      );
  }
}