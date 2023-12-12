import 'package:flutter/material.dart';

class BrickScreen extends StatelessWidget {
  final brickX;
  final brickY;
  final brickWidth;
  final brickHeight;
  final brickBroken;

   BrickScreen({this.brickHeight, this.brickWidth, this.brickX, this.brickY, required this.brickBroken});

  @override
  Widget build(BuildContext context) {
    return brickBroken ? Container() : Container(
    alignment: Alignment(brickX, brickY),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: Colors.amber,
        width: MediaQuery.of(context).size.width *brickWidth /2,
        height: MediaQuery.of(context).size.height *brickHeight /2,
      ),
    ),
  );
  }
}