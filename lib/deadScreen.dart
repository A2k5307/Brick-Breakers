import 'package:flutter/material.dart';

class DeadScreen extends StatelessWidget {
  final bool isGameOver;

  DeadScreen({required this.isGameOver});

  @override
  Widget build(BuildContext context) {
    return isGameOver ? Container(
      alignment: const Alignment(0, -0.3),
      child: const Text("G A M E   O V E R"),
    ) : Container();
  }
}