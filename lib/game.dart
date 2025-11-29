/** Classe Game
 *  Logique et contrôle du jeu
 *  + Validation des entrées (Personne 4)
 */
import 'dart:io';

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

  // ========= PERSONNE 4 : VALIDATION DES ENTRÉES =========

  /// Lit un entier entre [min] et [max] (inclus) de façon sécurisée.
  /// Redemande tant que l'utilisateur ne donne pas une valeur correcte.
  int _readIntInRange(String message, int min, int max) {
    while (true) {
      stdout.write(message);
      final input = stdin.readLineSync();

      final value = int.tryParse(input ?? '');
      if (value == null) {
        print("Veuillez entrer un nombre entier.");
        continue;
      }

      if (value < min || value > max) {
        print("Veuillez entrer un nombre entre $min et $max.");
        continue;
      }

      return value;
    }
  }

  /// Demande à l'utilisateur une position valide (row, col) :
  /// - ligne et colonne entre 0 et 2
  /// - case non occupée
  /// Retourne une liste [row, col] toujours valide.
  List<int> _askValidMove() {
    while (true) {
      print("\nTour de ${currentPlayer.name} (${currentPlayer.symbol})");

      final row = _readIntInRange("Entrez la ligne (0-2) : ", 0, 2);
      final col = _readIntInRange("Entrez la colonne (0-2) : ", 0, 2);

      // Vérifier que la case est libre (Personne 4 + Board de Personne 2)
      if (!board.isCellEmpty(row, col)) {
        print("Cette case est déjà occupée, choisissez une autre case.");
        continue;
      }

      return [row, col];
    }
  }

  /// Méthode appelée par main.dart si on veut que Game
  /// s'occupe lui-même de la saisie et de la validation.
  /// Personne 5 peut faire :
  ///   bool finished = game.playOneTurnWithInput();
  bool playOneTurnWithInput() {
    final move = _askValidMove(); // Personne 4
    final row = move[0];
    final col = move[1];

    // Ici on appelle la logique déjà définie (Personne 3)
    return playTurn(row, col);
  }

  // ========= TON CODE D'ORIGINE (Personne 3) =========

  // Fonction appelée à chaque tour depuis main.dart
  // (Personne 5 va l’appeler si elle gère elle-même row/col)
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
