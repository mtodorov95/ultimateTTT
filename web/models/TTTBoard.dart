class TTTBoard {
  static const List<List<int>> WIN_PATTERNS = const [
    const [0, 1, 2],
    const [3, 4, 5],
    const [6, 7, 8],
    const [0, 3, 6],
    const [1, 4, 7],
    const [2, 5, 8],
    const [0, 4, 8],
    const [2, 4, 6]
  ];

  List<String> _board;
  int _moveCount;

  TTTBoard() {
    _moveCount = 0;
    _board = List<String>.filled(9, null);
  }

  bool get isFull => _moveCount >= 9;
  bool get isNotFull => !isFull;

  String move(int square, String player) {
    _board[square] = player;
    _moveCount++;
    return getWinner();
  }

  String getWinner() {
    for (List<int> pattern in WIN_PATTERNS) {
      String square1 = _board[pattern[0]];
      String square2 = _board[pattern[1]];
      String square3 = _board[pattern[2]];

      if (square1 != null && square1 == square2 && square2 == square3) {
        return square1;
      }
    }
    return null;
  }

  List<int> get emptySquares {
    List<int> empty = [];
    for (int i = 0; i < _board.length; i++) {
      if (_board[i] == null) {
        empty.add(i);
      }
    }
    return empty;
  }

  String operator [](int square) => _board[square];

  @override
  String toString() {
    String prettify(int square) => _board[square] ?? ' ';

    return """
    ${prettify(0)} | ${prettify(1)} | ${prettify(2)}
    ${prettify(3)} | ${prettify(4)} | ${prettify(5)}
    ${prettify(6)} | ${prettify(7)} | ${prettify(8)}
    """;
  }
}
