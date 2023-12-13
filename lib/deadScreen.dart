import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeadScreen extends StatelessWidget {
  final bool isGameOver;
  final function;

  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.amber[600], letterSpacing: 0, fontSize: 20
    )
  );

  DeadScreen({required this.isGameOver, this.function});

  @override
  Widget build(BuildContext context) {
    return isGameOver ? Stack(
      children: [
         Container(
        alignment: const Alignment(0, -0.3),
        child: Text("G A M E   O V E R",
        style: gameFont,
        ),
      ),
      Container(
        alignment: const Alignment(0, 0),
        child: GestureDetector(
          onTap: function,
          child: ClipRRect(

            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.amber,
              child: Text("Play Again",
              style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      )
    ],
    )
    
    : Container();
  }
}