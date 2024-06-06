import 'dart:io';
import 'dart:math';

class Chessboard {
  Map<String, String> _board;
  Random _random;

  Chessboard()
      : _board = _createChessboard(),
        _random = Random();

  static Map<String, String> _createChessboard() {
    var chessboard = <String, String>{};
    var columns = 'abcdefgh';
    var rows = '12345678';
    for (var col in columns.runes) {
      for (var row in rows.runes) {
        var square = String.fromCharCode(col) + String.fromCharCode(row);
        if ((columns.indexOf(String.fromCharCode(col)) +
                rows.indexOf(String.fromCharCode(row))) %
            2 ==
            0) {
          chessboard[square] = 'b';
        } else {
          chessboard[square] = 'w';
        }
      }
    }
    return chessboard;
  }

  String? getColor(String square) {
    return _board[square];
  }

  void removeSquare(String square) {
    _board.remove(square);
  }

  bool isEmpty() {
    return _board.isEmpty;
  }

  List<String> getSquares() {
    return _board.keys.toList();
  }

  String randomSquare() {
    var squares = getSquares();
    return squares[_random.nextInt(squares.length)];
  }
}

class Game {
  Chessboard _chessboard;
  int _correctAnswers;

  Game()
      : _chessboard = Chessboard(),
        _correctAnswers = 64; // Total number of squares on a chessboard

  void start() {
    while (_correctAnswers > 0) {
      var randomSquare = _chessboard.randomSquare();

      print("What's the color of the '$randomSquare' square?");
      var userInput = stdin.readLineSync()?.trim().toLowerCase();

      if (userInput == 'quit') {
        print("Thanks for playing!");
        break;
      } else if (userInput == _chessboard.getColor(randomSquare)) {
        print("Correct! '$randomSquare' square is indeed $userInput.");
        _chessboard.removeSquare(randomSquare);
        _correctAnswers--;
      } else {
        print("Incorrect. '$randomSquare' square is ${_chessboard.getColor(randomSquare)}.");
      }

      if (_chessboard.isEmpty()) {
        print("Congratulations! You have guessed all squares correctly.");
        break;
      }
    }
  }
}

void main() {
  var game = Game();
  game.start();
}
