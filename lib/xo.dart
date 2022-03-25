import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  List<List<String>> matrix = [
    ["", "", ""],
    ["", "", ""],
    ["", "", ""],
  ];
  String _char = "X";
  int _scoreX = 0;
  int _scoreO = 0;
  int filled = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _newGame();
            },
          )
        ],
        title: const Text(
          'Tic Tac Toe',
          style: TextStyle(
              fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text(
                      "Player X",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$_scoreX",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "Player O",
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "$_scoreO",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElement(0, 0),
                    buildElement(0, 1),
                    buildElement(0, 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElement(1, 0),
                    buildElement(1, 1),
                    buildElement(1, 2),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElement(2, 0),
                    buildElement(2, 1),
                    buildElement(2, 2),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container buildElement(int row, int col) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (matrix[row][col].isEmpty) {
              matrix[row][col] = _char;
              _char = _char == "X" ? "O" : "X";
              var winner = checkWinner();
              if (winner.isNotEmpty) {
                switch (winner) {
                  case "X":
                    {
                      _scoreX++;
                      showAlertDialog("The Winner is Player X");
                      _clear();
                      break;
                    }
                  case "O":
                    {
                      _scoreO++;
                      _clear();
                      showAlertDialog("The Winner is Player O");
                      break;
                    }
                  case "draw":
                    {
                      showAlertDialog("No Winners");
                      _clear();
                    }
                    break;
                }
              }
            }
          });
        },
        child: Text(
          matrix[row][col],
          style: TextStyle(
              color: _char == "O" ? Colors.white : Colors.red, fontSize: 30),
        ),
      ),
    );
  }

  String checkWinner() {
    filled++;
    if (matrix[0][0] == matrix[0][1] && matrix[0][0] == matrix[0][2]) {
      return matrix[0][0];
    } else if (matrix[1][0] == matrix[1][1] && matrix[1][0] == matrix[1][2]) {
      return matrix[1][0];
    } else if (matrix[2][0] == matrix[2][1] && matrix[2][0] == matrix[2][2]) {
      return matrix[2][0];
    } else if (matrix[0][0] == matrix[1][0] && matrix[0][0] == matrix[2][0]) {
      return matrix[0][0];
    } else if (matrix[0][1] == matrix[1][1] && matrix[0][1] == matrix[2][1]) {
      return matrix[0][1];
    } else if (matrix[0][2] == matrix[1][2] && matrix[0][2] == matrix[2][2]) {
      return matrix[0][2];
    } else if (matrix[0][0] == matrix[1][1] && matrix[0][0] == matrix[2][2]) {
      return matrix[0][0];
    } else if (matrix[0][2] == matrix[1][1] && matrix[0][2] == matrix[2][0]) {
      return matrix[0][2];
    } else if (filled >= 9) {
      return "draw";
    }
    return '';
  }

  Future<dynamic> showAlertDialog(String message) {
    return showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Play again"),
                )
              ],
            ),
          );
        });
  }

  void _clear() {
    setState(() {});
    matrix = [
      ["", "", ""],
      ["", "", ""],
      ["", "", ""]
    ];
    _char = "X";
    filled = 0;
  }

  void _newGame() {
    setState(() {});
    matrix = [
      ["", "", ""],
      ["", "", ""],
      ["", "", ""]
    ];
    _char = "X";
    _scoreO = 0;
    _scoreX = 0;
    filled = 0;
  }
}
