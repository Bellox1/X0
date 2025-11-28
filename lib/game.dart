/** Classe Game Logique et contrôle du jeu */
import 'player.dart';
import 'board.dart';

class Game {
  final Player player1;
  final Player player2;
  late Player currentPlayer;
  final Board board;

  Game(this.player1, this.player2, this.board) {
    // Personne 3 décide qui commence
    currentPlayer = player1;
  }

  // Fonction appelée à chaque tour depuis main.dart
  // (Personne 5 va l’appeler)
  bool playTurn(int row, int col) {
    // Personne 4 aura vérifié row/col avant
    // Personne 2 va mettre à jour la grille

    board.updateCell(row, col, currentPlayer.symbol);

    // Vérifie si ce joueur gagne
    if (board.checkWin(currentPlayer.symbol)) {
      return true; // Partie terminée
    }

    // Vérifie si match nul
    if (board.isFull()) {
      return true;
    }

    // Sinon, changer de joueur
    _switchPlayer();

    return false; // Partie continue
  }

  void _switchPlayer() {
    currentPlayer = (currentPlayer == player1) ? player2 : player1;
  }
}
