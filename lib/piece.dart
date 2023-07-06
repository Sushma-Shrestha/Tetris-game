import 'dart:ui';

import 'package:tetris/board.dart';
import 'package:tetris/values.dart';

int rowLength = 10;
int colLength = 15;

class Piece {
  Tetromino type;

  Piece({required this.type});

  List<int> position = [];

  Color get color => tetrominoColors[type]!;

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        position = [-20, -10, -19, -9];
        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetromino.Z:
        position = [-27, -28, -17, -16];
        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];
        break;
      default:
      // break;
    }
  }

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.left:
        // position = position.map((e) => e - 1).toList();
        for (int i = 0; i < position.length; i++) {
          position[i] = position[i] - 1;
        }
        break;
      case Direction.right:
        // position = position.map((e) => e + 1).toList();
        for (int i = 0; i < position.length; i++) {
          position[i] = position[i] + 1;
        }
        break;
      case Direction.down:
        // position = position.map((e) => e + 10).toList();
        for (int i = 0; i < position.length; i++) {
          position[i] = position[i] + rowLength;
        }
        break;
    }
  }

  int rotationState = 1;

  void rotatePiece() {
    List<int> rotatedPosition = [];

    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            rotatedPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            rotatedPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            rotatedPosition = [
              position[1] - rowLength - 1,
              position[1] - rowLength,
              position[1],
              position[1] + rowLength
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            rotatedPosition = [
              position[1] - rowLength + 1,
              position[1] - 1,
              position[1],
              position[1] + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.J:
        switch (rotationState) {
          case 0:
            rotatedPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            rotatedPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] - rowLength + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            rotatedPosition = [
              position[1] - rowLength - 1,
              position[1] - rowLength,
              position[1],
              position[1] + rowLength
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            rotatedPosition = [
              position[1] - rowLength - 1,
              position[1] - 1,
              position[1],
              position[1] + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            rotatedPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength * 2
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            rotatedPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            rotatedPosition = [
              position[1] - rowLength - 1,
              position[1] - rowLength,
              position[1],
              position[1] + rowLength
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            rotatedPosition = [
              position[1] - rowLength + 1,
              position[1] - 1,
              position[1],
              position[1] + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.O:
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            rotatedPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            rotatedPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            rotatedPosition = [
              position[1] - rowLength - 1,
              position[1] - rowLength,
              position[1],
              position[1] + rowLength
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            rotatedPosition = [
              position[1] - rowLength + 1,
              position[1] - 1,
              position[1],
              position[1] + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            rotatedPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            rotatedPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            rotatedPosition = [
              position[1] - rowLength - 1,
              position[1] - rowLength,
              position[1],
              position[1] + rowLength
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            rotatedPosition = [
              position[1] - rowLength + 1,
              position[1] - 1,
              position[1],
              position[1] + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      case Tetromino.T:
        switch (rotationState) {
          case 0:
            rotatedPosition = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            rotatedPosition = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            rotatedPosition = [
              position[1] - rowLength - 1,
              position[1] - rowLength,
              position[1],
              position[1] + rowLength
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            rotatedPosition = [
              position[1] - rowLength + 1,
              position[1] - 1,
              position[1],
              position[1] + 1
            ];
            if (piecePositionIsValid(rotatedPosition)) {
              position = rotatedPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;

      default:
      // do something
    }
  }

  // check if valid position
  bool positionIsValid(int position) {
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    } else {
      return true;
    }
  }

  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition) {
      if (!positionIsValid(pos)) {
        return false;
      }

      int col = pos % rowLength;

      // check if the first or last column is occupied

      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    return !(firstColOccupied && lastColOccupied);
  }
}
