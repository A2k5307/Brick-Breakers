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
  double ballXIncrement = 0.02;
  double ballYIncrement = 0.01;
  var ballYDirection = Direction.DOWN;
  var ballXDirection = Direction.LEFT;

  //player alignment
  double playerX = -0.2;
  double playerwidth = 0.4;

  //brick properties
  static double firstBrickX = -1 + wallGap;  
  static double firstBrickY = -0.9;
  static double brickHeight = 0.05;
  static double brickWidth = 0.4; 
  static double brickGap = 0.01; 
  static int numberOfBricksInRow = 4;
  static double wallGap = 0.5 * (2 - numberOfBricksInRow * brickWidth - (numberOfBricksInRow -1) * brickGap);
  bool brickBroken = false;

  List myBricks = [
    // [X, Y, BrickBroken]
    [firstBrickX + 0 * (brickWidth + brickGap),firstBrickY,false],
    [firstBrickX + 1 * (brickWidth + brickGap),firstBrickY,false],
    [firstBrickX + 2 * (brickWidth + brickGap),firstBrickY,false],
    [firstBrickX + 3 * (brickWidth + brickGap),firstBrickY,false],
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
  //check for when ball is inside the brick (aka hits bricks)
    for(int i = 0; i < myBricks.length; i++)
    {
      if(ballX >= myBricks[i][0] &&
       ballX <= myBricks[i][0] + brickWidth &&
       ballY <= myBricks[i][1] + brickHeight &&
       myBricks[i][2] == false){
       setState(() {
         myBricks[i][2] = true;

        //since brick is broken,change direction of ball
        //based on which side the ball is hit
        // to do this, calculate the diastance of the ball from each of the 4 sides
        ////the smallest distance is the side of ball has it
        
        double leftSideDist = (myBricks[i][0] - ballX).abs();
        double rightSideDist = (myBricks[i][0] + brickWidth - ballX).abs();
        double topSideDist = (myBricks[i][0] - ballY).abs();
        double bottomSideDist = (myBricks[i][0] + brickHeight - ballY).abs();

        String min = findMin(leftSideDist, rightSideDist, topSideDist, bottomSideDist);

        switch ( min) 
        {
          case 'left' : ballYDirection = Direction.LEFT;

          break;
          case 'right' : ballYDirection = Direction.RIGHT;

          break;
          case 'up' : ballYDirection = Direction.UP;

          break;
          case 'down' : ballYDirection = Direction.DOWN;

          break;
        }

       }
      );
     }  
    }  
   }
  //return the smallest side
  String findMin(double a, double b, double c, double d)
  {
    List<double> myList = [
      a,
      b,
      c,
      d,
    ];
  double currentMin = a;
  for (int i =0; i < myList.length; i++)
  {
    if(myList[i] < currentMin)
    {
      currentMin = myList[i];
    }
  }

  if((currentMin - a).abs() < 0.01)
  {
    return 'left';
  }else if((currentMin - b).abs() < 0.01)
  {
    return 'rigth';
  }else if((currentMin - c).abs() < 0.01)
  {
    return 'top';
  }else if((currentMin - d).abs() < 0.01)
  {
    return 'bottom';
  }

  return '';
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
                     brickBroken: myBricks[0][2],
                  ),
                  BrickScreen(
                    brickHeight: brickHeight,
                     brickWidth: brickWidth,
                     brickX: myBricks[1][0],
                     brickY: myBricks[1][1],
                     brickBroken: myBricks[1][2],
                  ),
                  BrickScreen(
                    brickHeight: brickHeight,
                     brickWidth: brickWidth,
                     brickX: myBricks[2][0],
                     brickY: myBricks[2][1],
                     brickBroken: myBricks[2][2],
                  ),
                  BrickScreen(
                    brickHeight: brickHeight,
                     brickWidth: brickWidth,
                     brickX: myBricks[3][0],
                     brickY: myBricks[3][1],
                     brickBroken: myBricks[3][2],
                  ),
                ],
              ),
            ),
        ),
      ),
    );
  }
}