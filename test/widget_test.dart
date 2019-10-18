import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_starter/gamelogic.dart';
main() {

  List<List<Token>> board = [
    [null, null, null],
    [null, null, null],
    [null, null, null]
  ];
  board[2][2] = Token.x;
test('full board test', (){
  expect(fullBoard(board), false);
});
}
