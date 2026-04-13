import 'package:flutter/material.dart';
import 'package:chess/chess.dart' as chess;

class GameState extends ChangeNotifier {
  chess.Chess _game = chess.Chess();
  bool _isPlayerTurn = true;
  String? _winner;
  List<String> _moveHistory = [];

  chess.Chess get game => _game;
  bool get isPlayerTurn => _isPlayerTurn;
  String? get winner => _winner;
  List<String> get moveHistory => _moveHistory;

  void resetGame() {
    _game = chess.Chess();
    _isPlayerTurn = true;
    _winner = null;
    _moveHistory = [];
    notifyListeners();
  }

  bool makeMove(String from, String to) {
    try {
      final move = _game.move({
        'from': from,
        'to': to,
        'promotion': 'q', // ترقية إلى ملكة افتراضياً
      });
      
      if (move != null) {
        _moveHistory.add('${move.from} → ${move.to}');
        _isPlayerTurn = false;
        notifyListeners();
        
        // التحقق من الكش مات أو التعادل
        if (_game.gameOver()) {
          if (_game.inCheckmate()) {
            _winner = _game.turn() == 'w' ? 'الأسود' : 'الأبيض';
          } else {
            _winner = 'تعادل';
          }
          notifyListeners();
        }
        
        // هنا يمكن إضافة حركة الذكاء الاصطناعي لاحقاً
        _aiMove();
        return true;
      }
    } catch (e) {
      debugPrint('خطأ في الحركة: $e');
    }
    return false;
  }

  void _aiMove() {
    if (!_game.gameOver() && !_isPlayerTurn) {
      // مؤقت بسيط لمحاكاة تفكير AI
      Future.delayed(const Duration(milliseconds: 500), () {
        final moves = _game.moves();
        if (moves.isNotEmpty) {
          final randomMove = moves[DateTime.now().millisecondsSinceEpoch % moves.length];
          _game.move(randomMove);
          _moveHistory.add('AI: $randomMove');
          _isPlayerTurn = true;
          
          if (_game.gameOver()) {
            if (_game.inCheckmate()) {
              _winner = _game.turn() == 'w' ? 'الأسود' : 'الأبيض';
            } else {
              _winner = 'تعادل';
            }
          }
          notifyListeners();
        }
      });
    }
  }

  // الحصول على حالة المربعات
  Map<String, dynamic> getBoardState() {
    return {
      'board': _game.board(),
      'turn': _game.turn(),
      'inCheck': _game.inCheck(),
      'inCheckmate': _game.inCheckmate(),
      'inStalemate': _game.inStalemate(),
      'inDraw': _game.inDraw(),
    };
  }
}
