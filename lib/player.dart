/** Class joueur */
class Player {
  final String name;
  final String symbol;

  Player(String name, String symbol) : this.name = name, this.symbol = symbol {
    if (symbol != "X" && symbol != "O") {
      throw ArgumentError("Les symboles utilisés doivent être 'X' ou 'O'.");
    }
  }

  @override
  String toString() {
    return '$name ($symbol)';
  }
}

void main() {
  // final playerX = Player("Joueur 1", "X");
  // final playerO = Player("Joueur 2", "O");

  // print("Création réussie :");
  // print("- $playerX");
  // print("- $playerO");
}