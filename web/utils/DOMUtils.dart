import 'dart:html';

class DOMUtils {
  DivElement getMainSquareDiv(int mainSquare) {
    return querySelector('.main-square[data-square="$mainSquare"]');
  }

  DivElement getLittleSquareDiv(int mainSquare, int littleSquare) {
    return querySelector(
        '.main-square[data-square="$mainSquare"] > [data-square="$littleSquare"]');
  }

  bool toggleHighlight(DivElement squareDiv) {
    return squareDiv.classes.toggle('available-square');
  }

  String markSquare(DivElement squareDiv, String player) {
    return squareDiv.text = player;
  }

  String showMessage(DivElement messageDiv, String message) =>
      messageDiv.text = message;
}
