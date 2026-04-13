import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_chessboard/flutter_chessboard.dart';
import '../models/game_state.dart';
import '../utils/theme.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String? _selectedSquare;
  ChessboardController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = ChessboardController();
  }

  @override
  Widget build(BuildContext context) {
    final gameState = Provider.of<GameState>(context);
    
    return Scaffold(
      backgroundColor: isDarkMode(context) ? const Color(0xFF1A1A2E) : Colors.white,
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'شطة',
                style: TextStyle(
                  color: const Color(0xFFB71C1C),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              TextSpan(
                text: ' ',
              ),
              TextSpan(
                text: 'رنج',
                style: TextStyle(
                  color: isDarkMode(context) ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFB71C1C),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              gameState.resetGame();
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // حالة اللعبة
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFD700), Color(0xFFFFA000)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'دور: ${gameState.isPlayerTurn ? "أنت" : "الخصم"}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                if (gameState.winner != null)
                  Text(
                    'الفائز: ${gameState.winner}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFFB71C1C),
                    ),
                  ),
              ],
            ),
          ),
          // رقعة الشطرنج
          Expanded(
            child: Center(
              child: Chessboard(
                controller: _controller!,
                boardColor: BoardColor(
                  lightSquare: isDarkMode(context) ? const Color(0xFF2D2D44) : const Color(0xFFF0D9B5),
                  darkSquare: isDarkMode(context) ? const Color(0xFF1E1E2F) : const Color(0xFFB58863),
                ),
                pieceSet: PieceSet.merida,
                size: MediaQuery.of(context).size.width * 0.9,
                onMove: (move) {
                  final success = gameState.makeMove(move.from, move.to);
                  if (success) {
                    _selectedSquare = null;
                    setState(() {});
                  }
                  return success;
                },
                onSquareTapped: (square) {
                  setState(() {
                    _selectedSquare = square;
                  });
                },
                selectedSquare: _selectedSquare,
                enableDrag: true,
                lastMove: gameState.moveHistory.isNotEmpty
                    ? Move(
                        from: gameState.moveHistory.last.split(' → ')[0],
                        to: gameState.moveHistory.last.split(' → ')[1],
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // زر إعادة الضبط
          ElevatedButton.icon(
            onPressed: () {
              gameState.resetGame();
              setState(() {});
            },
            icon: const Icon(Icons.restart_alt),
            label: const Text('بدء لعبة جديدة'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB71C1C),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

bool isDarkMode(BuildContext context) {
  return Theme.of(context).brightness == Brightness.dark;
}
