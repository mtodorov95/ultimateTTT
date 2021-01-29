import 'dart:html';
import 'models/TTTBoard.dart';

void main() {
  TTTBoard testBoard = new TTTBoard();

  print("Winner: ${testBoard.move(4, 'X')}");
  print(testBoard);
  print("Winner: ${testBoard.move(8, 'O')}");
  print(testBoard);
  print("Winner: ${testBoard.move(6, 'X')}");
  print(testBoard);
  print("Winner: ${testBoard.move(5, 'O')}");
  print(testBoard);
  print("Winner: ${testBoard.move(2, 'X')}");
  print(testBoard);
}
