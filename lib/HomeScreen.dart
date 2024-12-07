import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String? winner;
  bool gameOver = false;
  int? selectedCell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        backgroundColor: Colors.black,
        title: const Text(
          'X and O',
          style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Player : $currentPlayer',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (!gameOver && board[index] == '') {
                      setState(() {
                        board[index] = currentPlayer;
                        checkWinner();
                        currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
                        selectedCell = index;
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      color: selectedCell == index ? Colors.blue : Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        board[index],
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            if (gameOver)
              Text(
                winner != null ? 'Winner: $winner' : 'It\'s a draw!',
                style: const TextStyle(fontSize: 20),
              ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: restartGame,
              child: const Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }

  void checkWinner() {
    for (int i = 0; i < 9; i += 3) {
      if (board[i] == board[i + 1] && board[i] == board[i + 2] && board[i] != '') {
        winner = board[i];
        gameOver = true;
        return;
      }
    }

    for (int i = 0; i < 3; i++) {
      if (board[i] == board[i + 3] && board[i] == board[i + 6] && board[i] != '') {
        winner = board[i];
        gameOver = true;
        return;
      }
    }

    if ((board[0] == board[4] && board[0] == board[8] && board[0] != '') ||
        (board[2] == board[4] && board[2] == board[6] && board[2] != '')) {
      winner = board[4];
      gameOver = true;
      return;
    }

    if (!board.contains('')) {
      gameOver = true;
      return;
    }
  }

  void restartGame() {
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = null;
      gameOver = false;
      selectedCell = null;
    });
  }
}
