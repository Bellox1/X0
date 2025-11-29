import 'dart:io';
import '../lib/player.dart';
import '../lib/board.dart';
import '../lib/game.dart';

void main() {
  print('=== 🎮 Jeu de Morpion 🎮 ===\n');
  
  // Initialisation des joueurs
  final player1 = Player('Joueur 1', 'X');
  final player2 = Player('Joueur 2', 'O');
  
  // Initialisation du jeu
  final game = Game(player1, player2, Board());
  
  // Boucle principale du jeu
  bool gameOver = false;
  while (!gameOver) {
    // Afficher le plateau
    _clearScreen();
    print('=== Tour de ${game.currentPlayer.name} (${game.currentPlayer.symbol}) ===\n');
    game.board.display();
    
    // Jouer un tour
    gameOver = game.playOneTurnWithInput();
    
    // Vérifier si la partie est terminée
    if (gameOver) {
      _clearScreen();
      game.board.display();
      
      if (game.board.checkWin(game.currentPlayer.symbol)) {
        print('\n🎉 Félicitations ${game.currentPlayer.name} a gagné ! 🎉');
      } else {
        print('\n🤝 Match nul ! 🤝');
      }
      
      // Demander si on veut rejouer
      if (_askToPlayAgain()) {
        // Réinitialiser le jeu
        game.board.reset();
        gameOver = false;
      }
    }
  }
}

/// Efface l'écran de la console
void _clearScreen() {
  if (Platform.isWindows) {
    print(Process.runSync('cls', [], runInShell: true).stdout);
  } else {
    print(Process.runSync('clear', [], runInShell: true).stdout);
  }
}

/// Demande à l'utilisateur s'il veut rejouer
bool _askToPlayAgain() {
  while (true) {
    stdout.write('\nVoulez-vous rejouer ? (o/n) : ');
    final response = stdin.readLineSync()?.toLowerCase().trim();
    
    if (response == 'o' || response == 'oui') {
      return true;
    } else if (response == 'n' || response == 'non') {
      print('\nMerci d\'avoir joué ! À bientôt ! 👋');
      return false;
    }
    
    print('Veuillez répondre par "o" ou "n".');
  }
}