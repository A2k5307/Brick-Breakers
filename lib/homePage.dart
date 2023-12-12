import 'dart:async';
import 'package:brick_breakers/Bricks.dart';
import 'package:brick_breakers/ball.dart';
import 'package:brick_breakers/coverScreen.dart';
import 'package:brick_breakers/deadScreen.dart';
import 'package:brick_breakers/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

  enum Direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {

  //ball aligment
  double ballX = 0;
  double ballY = 0;
  double ballXIncrement = 0.01;
  double ballYIncrement = 0.01;
  var ballYDirection = Direction.DOWN;
  var ballXDirection = Direction.LEFT;

  //player alignment
  double playerX = -0.2;
  double playerwidth = 0.4;

  //brick properties
  static double firstBrickX = -0.5;  
  static double firstBrickY = -0.9;
  static double brickHeight = 0.05;
  static double brickWidth = 0.4; 
  static double brickGap = 0.2.; 
  bool brickBroken = false;

  List myBricks = [
    // [X, Y, BrickBroken]
    [firstBrickX,firstBrickY,false],
    [firstBrickX + brickWidth + brickGap,firstBrickY,false],
  ];
  //game setting
  bool hasGameStarted = false;
  bool isGameOver = false;


  //Start game
  void startGame() { 
    hasGameStarted = true;
    Timer.periodic(const Duration(milliseconds: 10), (timer) {
      //update direction
     updateDirection();

      //ball move
     moveBall();

     //check if player dead
     if(isPlayerDead())
     {
      timer.cancel();
      isGameOver = true;
     }

    //Check if player dead
    brokenBrick();

     });
  }

  void brokenBrick(){
    if(ballX >= myBricks[0][0] &&
       ballX <= myBricks[0][0] + brickWidth &&
       ballY <= myBricks[0][1] + brickHeight &&
       brickBroken == false){
       setState(() {
         brickBroken = true;
         ballYDirection = Direction.DOWN;
       });
    }    
  }


  bool isPlayerDead(){
    if(ballY >= 1)
    {
      return true;
    }

     return false;
  }

  void moveBall(){
    setState(() {
      //move vertically
      if( ballXDirection == Direction.LEFT)
      {
      ballX -= ballXIncrement;
      }else if( ballXDirection == Direction.RIGHT)
      {
      ballX += ballXIncrement;
      }

      //move vertically
      if( ballYDirection == Direction.DOWN)
      {
      ballY += ballYIncrement;
      }else if( ballYDirection == Direction.UP)
      {
      ballY -= ballYIncrement;
      }
      
    });
  }

  void updateDirection(){
    setState(() {
      //ball goes up when hit player
      if(ballY >= 0.9 && ballX >= playerX && ballX <= playerX +playerwidth)
      {
        ballYDirection = Direction.UP;
      }
      //ball goes down when hit brick
      else if(ballY <= -1)
      {
        ballYDirection = Direction.DOWN;
      }

      //ball goes left when hit right ball
      if(ballX >= 1)
      {
        ballXDirection = Direction.LEFT;
      }

      // //ball goes right when hit left ball
      else if(ballX <= -1)
      {
        ballXDirection = Direction.RIGHT;
      }
    });
  }

  //go left
  moveleft(){
    setState(() {
      if(!(playerX - 0.2 < -1))
      {
      playerX -= 0.2;
      }
    });
  }

  //go right
  moveright(){
    setState(() {
      if(!(playerX + playerwidth >= 1))
      {
      playerX += 0.2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event){
      if(event.isKeyPressed(LogicalKeyboardKey.arrowLeft))
      {
        moveleft();
      }
      else if(event.isKeyPressed(LogicalKeyboardKey.arrowRight))
      {
        moveright();
      }
      },
      child: GestureDetector(
        onTap: startGame,
        child: Scaffold(
          backgroundColor: Colors.amber[100],
            body: Center(
              child: Stack(
                children: [
                  
                  //START GAME BUTTON
                  CoverScreen(
                    hasGameStarted: hasGameStarted
                    ),

                  DeadScreen(isGameOver: isGameOver),
                  
                  //My Ball
                  MyBall(
                    ballX: ballX,
                    ballY: ballY,
                  ),

                  //My player
                  MyPlayer(
                    playerX: playerX,
                    playerwidth: playerwidth,
                  ),

                  BrickScreen(
                    brickHeight: brickHeight,
                     brickWidth: brickWidth,
                     brickX: myBricks[0][0],
                     brickY: myBricks[0][1],
                     brickBroken: brickBroken,
                  ),
                  BrickScreen(
                    brickHeight: brickHeight,
                     brickWidth: brickWidth,
                     brickX: myBricks[1][0],
                     brickY: myBricks[1][1],
                     brickBroken: brickBroken,
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}