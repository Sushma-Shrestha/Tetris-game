import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/values.dart';

// int rowLength = 10;
// int colLength = 15;

/*
Game board

This is a 2x2 grid with null representing an empty space.
An non empty space will have the color to represent the landed pieces
*/

// create game board

List<List<Tetromino?>> gameBoard = List.generate(
    colLength, (index) => List.generate(rowLength, (index) => null));

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // int rowLength = 10;
  // int colLength = 15;

  // current Tetris piece
  Piece currentPiece = Piece(type: Tetromino.T);
  int currentScore = 0;
  bool GameOver = false;
  @override
  void initState() {
    super.initState();
    // currentPiece.initializePiece();

    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {
    //     currentPiece.position[0]++;
    //   });
    // });

    Duration frameRate = const Duration(milliseconds: 400);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    // Future.delayed(frameRate, () {
    //   setState(() {
    //     currentPiece.movePiece(Direction.down);
    //   });
    //   gameLoop(frameRate);
    // });
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // clear line
        clearLines();
        // check landing
        checkLanding();
        // check if game over
        if (GameOver) {
          timer.cancel();
          showGameOverDialog();
        }
        // move piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  void showGameOverDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Your score is $currentScore'),
            actions: [
              TextButton(
                  onPressed: () {
                    resetGame();
                    Navigator.pop(context);
                  },
                  child: Text('Play Again'))
            ],
          );
        });
  }

  void resetGame() {
    gameBoard = List.generate(
        colLength, (index) => List.generate(rowLength, (index) => null));
    currentScore = 0;
    GameOver = false;
    createNewPiece();
    startGame();
  }

  // cehck for collision detection
  bool checkColllision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      // if (currentPiece.position[i] % rowLength == 0 &&
      //     direction == Direction.left) {
      //   return true;
      // }
      // if (currentPiece.position[i] % rowLength == rowLength - 1 &&
      //     direction == Direction.right) {
      //   return true;
      // }
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // adjust row and col based on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if piece is out of bounds
      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
      // return false;
    }
    // if no collisopm detected return false

    return false;
  }

  void checkLanding() {
    if (checkColllision(Direction.down)) {
      // mark position as occupied
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        // int index = row * rowLength + col;
        // occupied[index] = true;
        // occupied[currentPiece.position[i]] = true;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      // stop the piece
      // check for game over
      // start new piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // currentPiece = Piece(type: Tetromino.T);
    // currentPiece.initializePiece();
    // create a random type
    Random rand = Random();
    Tetromino type = Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: type);
    currentPiece.initializePiece();

    // check for game over
    if (isGameOver()) {
      GameOver = true;
      // stop the game
      // show game over screen
    }
  }

  void moveLeft() {
    if (!checkColllision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkColllision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  void clearLines() {
    // Step 1: Loop through each row of the game board from bottom to top
    for (int row = colLength - 1; row >= 0; row--) {
      // Step 2: Check if the row is full, initialize a variable to track the row is full
      bool isFull = true;
      // check if the row is full (all columns in the row are filled with pieces)
      for (int col = 0; col < rowLength; col++) {
        // if any of the columns in the row is empty, the row is not full, break out of the loop
        if (gameBoard[row][col] == null) {
          isFull = false;
          break;
        }
      }
      // Step 3: If the row is full, clear row and shift all the rows above it down by 1
      if (isFull) {
        // Step 4: Remove the row
        // gameBoard.removeAt(row);
        // // Step 5: Add a new row at the top
        // gameBoard.insert(0, List.generate(rowLength, (index) => null));

        // move all the rows above it down by 1
        for (int r = row; r > 0; r--) {
          // for (int col = 0; col < rowLength; col++) {
          //   gameBoard[r][col] = gameBoard[r - 1][col];
          // }
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }
        // add a new row at the top
        gameBoard[0] = List.generate(rowLength, (index) => null);

        // increase score
        currentScore += 1;
      }
    }
  }

  bool isGameOver() {
    // check if the first row has any pieces
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        // game over
        // stop the game
        // show game over screen
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  itemCount: colLength * rowLength,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: rowLength),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    // get row and column of each index
                    int row = (index / rowLength).floor();
                    int col = index % rowLength;

                    // current piece
                    if (currentPiece.position.contains(index)) {
                      return Pixel(color: currentPiece.color);
                    }
                    // landed pieces
                    else if (gameBoard[row][col] != null) {
                      final color = tetrominoColors[gameBoard[row][col]]!;
                      return Pixel(color: color);
                    }

                    // blank pixel

                    else {
                      return Pixel(color: Colors.grey[800]);
                    }
                  }),
            ),
            Text('Score: $currentScore', style: TextStyle(color: Colors.white)),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: moveLeft,
                      icon: Icon(Icons.arrow_back_ios_new)),
                  IconButton(
                      onPressed: rotatePiece, icon: Icon(Icons.rotate_right)),
                  IconButton(
                      onPressed: moveRight,
                      icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            )
          ],
        ));
  }
}
