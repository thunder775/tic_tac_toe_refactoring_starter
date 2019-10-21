import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_starter/gamelogic.dart';

main() {
  board = [
    [null, null, null],
    [null, null, null],
    [null, null, null]
  ];
  board[2][2] = Token.x;
  test('full board test', () {
    expect(fullBoard(board), false);
  });
  test('text changeplayer if game is not over', () {
    expect(currentPlayer, Token.x);
    changePlayerIfGameIsNotOver();
    expect(currentPlayer, Token.o);
  });
  test('player doesn\'t change if board is full', () {
    currentPlayer = Token.x;
    board = [
      [Token.x, Token.o, Token.x],
      [Token.x, Token.o, Token.o],
      [Token.o, Token.x, Token.x]
    ];
    changePlayerIfGameIsNotOver();
    expect(currentPlayer, Token.x);
  });
  test('player doesn\'t change a player has won', () {
    currentPlayer = Token.x;
    board = [
      [Token.x, Token.o, null],
      [Token.x, Token.o, null],
      [Token.x, null, null]
    ];
    changePlayerIfGameIsNotOver();
    expect(currentPlayer, Token.x);
  });
}
