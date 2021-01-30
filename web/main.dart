import 'dart:html';
import 'dart:async' show StreamSubscription;
import 'models/TTTBoard.dart';
import 'utils/DOMUtils.dart';

TTTBoard mainBoard;
List<TTTBoard> littleBoards;
List<int> availableMainSqaures;
Map<DivElement, StreamSubscription> availableLittleSquares;
String currentPlayer;

DivElement mainBoardDiv = querySelector('#main-board');
DivElement messageDiv = querySelector('#message');

void main() {}
