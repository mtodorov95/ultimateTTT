import 'dart:html';
import 'dart:async' show StreamSubscription;
import 'models/TTTBoard.dart';
import 'utils/DOMUtils.dart';

DOMUtils utils = DOMUtils();
TTTBoard mainBoard;
List<TTTBoard> littleBoards;
List<int> availableMainSquares;
Map<DivElement, StreamSubscription> availableLittleSquares;
String currentPlayer;

DivElement mainBoardDiv = querySelector('#main-board');
DivElement messageDiv = querySelector('#message');

void main() {
  querySelector('#new-game-btn').onClick.listen(newGame);
  newGame();
}

void newGame([MouseEvent event]) {
  mainBoard = TTTBoard();
  littleBoards = List<TTTBoard>.generate(9, (_) => TTTBoard());
  currentPlayer = null;
  availableMainSquares = [];
  availableLittleSquares = {};

  createBoard();
  nextTurn();
}

void createBoard() {
  mainBoardDiv.children.clear();

  final List<String> layout = [
    "layout",
    "horizontal",
    "center",
    "center-justified"
  ];

  for (int mainSquare = 0; mainSquare < 9; mainSquare++) {
    DivElement mainSquareDiv = DivElement()
      ..classes.addAll(['main-square', 'wrap']..addAll(layout))
      ..attributes['data-square'] = mainSquare.toString();
    mainBoardDiv.append(mainSquareDiv);

    for (int littleSquare = 0; littleSquare < 9; littleSquare++) {
      mainSquareDiv.append(new DivElement()
        ..classes.addAll(["little-square"]..addAll(layout))
        ..attributes['data-square'] = littleSquare.toString());
    }
  }
}

void nextTurn([int lastLittleSquare]) {
  currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
  utils.showMessage(messageDiv, 'Player: $currentPlayer');

  if (lastLittleSquare != null &&
      mainBoard[lastLittleSquare] == null &&
      littleBoards[lastLittleSquare].isNotFull) {
    availableMainSquares = [lastLittleSquare];
  } else {
    availableMainSquares = mainBoard.emptySquares;
  }

  for (int mainSquare in availableMainSquares) {
    for (int littleSquare in littleBoards[mainSquare].emptySquares) {
      DivElement squareDiv = utils.getLittleSquareDiv(mainSquare, littleSquare);
      utils.toggleHighlight(squareDiv);
      availableLittleSquares[squareDiv] = squareDiv.onClick
          .listen((MouseEvent event) => move(mainSquare, littleSquare));
    }
  }
}

void move(int mainSquare, int littleSquare) {
  availableLittleSquares
    ..forEach((DivElement squareDiv, StreamSubscription listener) {
      utils.toggleHighlight(squareDiv);
      listener.cancel();
    })
    ..clear();

  String littleBoardWinner =
      littleBoards[mainSquare].move(littleSquare, currentPlayer);
  utils.markSquare(
      utils.getLittleSquareDiv(mainSquare, littleSquare), currentPlayer);

  if (littleBoardWinner != null) {
    String mainBoardWinner = mainBoard.move(mainSquare, littleBoardWinner);
    utils.markSquare(
        utils.getMainSquareDiv(mainSquare)..children.clear(), currentPlayer);

    if (mainBoardWinner != null) {
      utils.showMessage(messageDiv, 'Player $mainBoardWinner wins!');
      return;
    } else if (mainBoard.isFull) {
      utils.showMessage(messageDiv, "It's a tie!");
      return;
    }
  }
  nextTurn(littleSquare);
}
