import 'package:flutter/material.dart';

class MyPlayer extends StatelessWidget {

  final playerX;
  final playerwidth;

  MyPlayer({this.playerX, this.playerwidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment((2*playerX + playerwidth) / (2 - playerwidth), 0.9),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 10,
          width: MediaQuery.of(context).size.width * playerwidth / 2,
          color: Colors.amber,
        ),
      ),

    );
  }
}