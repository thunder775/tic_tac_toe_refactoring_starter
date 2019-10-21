import 'package:flutter/material.dart';

enum Token { o, x }

List<List<Token>> board = [
  [null, null, null],
  [null, null, null],
  [null, null, null]
];

// initial list of colors assigned to boxes on board
List<List<bool>> colorBoard = [
  [false, false, false],
  [false, false, false],
  [false, false, false]
];

Widget updateIcon(int r, int c) {
  if (board[r][c] == null) {
    return null;
  }
  if (board[r][c] == Token.x) {
    return xIcon;
  } else
    return oIcon;
}

//  takes an icon, checks if
bool legitMove(Token t) {
  return t == null && !winnerCheck(board);
}

//default parameters
Token currentPlayer = Token.x; //X will always be player 1
Icon xIcon = Icon(
  Icons.close,
  size: 90,
  color: Colors.white,
);
Icon oIcon = Icon(
  Icons.radio_button_unchecked,
  size: 90,
  color: Colors.white,
);
Icon playerIcon;

//function to change player based on currentPlayer value which is a string,
changePlayer(Token player) {
  if (player == Token.x) {
    currentPlayer = Token.o;
  } else if (player == Token.o) {
    currentPlayer = Token.x;
  }
  print('player changed to $currentPlayer');
}

Color winningColor = Colors.yellow.withOpacity(0.2);

void gameReset() {
  board = [
    [null, null, null],
    [null, null, null],
    [null, null, null]
  ];
  colorBoard = [
    [false, false, false],
    [false, false, false],
    [false, false, false]
  ];
  currentPlayer = Token.x;
}

bool fullBoard(List<List<Token>> board) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == null) {
        return false;
      }
    }
  }

  return true;
}

bool winnerCheck(List<List<Token>> board) {
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == Token.x &&
        board[i][1] == Token.x &&
        board[i][2] == Token.x) {
      colorBoard[i][0] = true;
      colorBoard[i][1] = true;
      colorBoard[i][2] = true;
      return true;
    }
    if (board[0][i] == Token.x &&
        board[1][i] == Token.x &&
        board[2][i] == Token.x) {
      colorBoard[0][i] = true;
      colorBoard[1][i] = true;
      colorBoard[2][i] = true;
      return true;
    }
    if (board[i][0] == Token.o &&
        board[i][1] == Token.o &&
        board[i][2] == Token.o) {
      colorBoard[i][0] = true;
      colorBoard[i][1] = true;
      colorBoard[i][2] = true;
      return true;
    }
    if (board[0][i] == Token.o &&
        board[1][i] == Token.o &&
        board[2][i] == Token.o) {
      colorBoard[0][i] = true;
      colorBoard[1][i] = true;
      colorBoard[2][i] = true;
      return true;
    }
  }
  if (board[0][0] == Token.x &&
      board[1][1] == Token.x &&
      board[2][2] == Token.x) {
    colorBoard[0][0] = true;
    colorBoard[1][1] = true;
    colorBoard[2][2] = true;
    return true;
  }
  if (board[0][2] == Token.x &&
      board[1][1] == Token.x &&
      board[2][0] == Token.x) {
    colorBoard[0][2] = true;
    colorBoard[1][1] = true;
    colorBoard[2][0] = true;
    return true;
  }
  if (board[0][0] == Token.o &&
      board[1][1] == Token.o &&
      board[2][2] == Token.o) {
    colorBoard[0][0] = true;
    colorBoard[1][1] = true;
    colorBoard[2][2] = true;
    return true;
  }
  if (board[0][2] == Token.o &&
      board[1][1] == Token.o &&
      board[2][0] == Token.o) {
    colorBoard[0][2] = true;
    colorBoard[1][1] = true;
    colorBoard[2][0] = true;
    return true;
  } else {
    return false;
  }
}

void changePlayerIfGameIsNotOver() {
//    if (winnerCheck(board)) {
//     // currentPlayer = "${currentPlayer.substring(7, 9)} Won";
//    } else if (fullBoard(board)) {
//    //  currentPlayer = "draw";
//    } else {
//      changePlayer(currentPlayer);
//    }
  if ((!winnerCheck(board)) && (!fullBoard(board))) {
    changePlayer(currentPlayer);
  }
}

// x won
// o won
// player x to move
// player o to move
// draw
String currentStatus() {
  if (winnerCheck(board)) {
    return 'player ${getCurrentPlayer()} won!';
  }
  if (fullBoard(board)) {
    return 'Draw';
  }
  return 'Player ${getCurrentPlayer()} to move';
}

String getCurrentPlayer() {
  return currentPlayer == Token.x ? 'X' : 'O';
}
