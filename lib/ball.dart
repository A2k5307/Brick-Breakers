import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class MyBall extends StatelessWidget {

  final ballX;
  final ballY;
  final bool hasGameStarted;
  final bool isGameOver;

  MyBall({this.ballX, this.ballY,required this.hasGameStarted,required this.isGameOver});
  @override
  Widget build(BuildContext context) {
    return hasGameStarted ? Container(
    alignment: Alignment(ballX, ballY),
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isGameOver ? Colors.amber[300] :Colors.amber[500],
      ),
      width: 10,
      height: 10,
    ),
  ) : Container(
    alignment: Alignment(ballX, ballY),
    child: AvatarGlow(
      endRadius: 60.0,
      child: Material(
      elevation: 8.0,
      shape: CircleBorder(),
      child: CircleAvatar(
        backgroundColor: Colors.amber[100],
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber,
          ),
          width: 15,
          height: 15,
        ), 
        radius: 7.0,
      ),
    )
  ),
  );
  }
}