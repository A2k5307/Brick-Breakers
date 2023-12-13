import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoverScreen extends StatelessWidget {
  final bool hasGameStarted;
  final bool isGameOver;

  
  static var gameFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(
      color: Colors.amber[600], letterSpacing: 0, fontSize: 20
    )
  );


  CoverScreen({required this.hasGameStarted, required this.isGameOver });

  @override
  Widget build(BuildContext context) {
    return hasGameStarted ? Container(
      
        alignment: const Alignment(0, -0.3),
        child: Text(isGameOver ? "" : "Pittho Garham",
        style: gameFont.copyWith(color: Colors.amber[200]),
        ),
    ) : 
    Stack(
      children: [
          Container(
        alignment: const Alignment(0, -0.3),
        child: Text("Pittho Garham",
        style: gameFont,
        ),
      ),
          Container(
        alignment: const Alignment(0, -0.1),
        child: const Text("Tap to Play",
        style: TextStyle(
          color: Colors.amber,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
    ],
    );
  }
}