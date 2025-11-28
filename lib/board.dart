class Board {
  List<List<String>> _grid;
  static const int _size = 3;
  
  Board() : _grid = List.generate(_size, (_) => List.filled(_size, ' '));
  
  int get size => _size;
  List<List<String>> get grid => _grid;
  
  void display() {
    print('\n   0   1   2');
    print('  ┌───┬───┬───┐');
    
    for (int i = 0; i < _size; i++) {
      String row = '$i │';
      for (int j = 0; j < _size; j++) {
        row += ' ${_grid[i][j]} │';
      }
      print(row);
      
      if (i < _size - 1) {
        print('  ├───┼───┼───┤');
      }
    }
    print('  └───┴───┴───┘\n');
  }
  
  bool makeMove(int row, int col, String symbol) {
    if (row < 0 || row >= _size || col < 0 || col >= _size) {
      return false;
    }
    if (_grid[row][col] != ' ') {
      return false;
    }
    
    _grid[row][col] = symbol;
    return true;
  }
  
  bool updateCell(int row, int col, String symbol) {
    return makeMove(row, col, symbol);
  }
  
  bool isFull() {
    for (int i = 0; i < _size; i++) {
      for (int j = 0; j < _size; j++) {
        if (_grid[i][j] == ' ') {
          return false;
        }
      }
    }
    return true;
  }
  
  bool checkWin(String symbol) {
    // Lignes
    for (int i = 0; i < _size; i++) {
      if (_grid[i][0] == symbol && _grid[i][1] == symbol && _grid[i][2] == symbol) {
        return true;
      }
    }
    
    // Colonnes
    for (int j = 0; j < _size; j++) {
      if (_grid[0][j] == symbol && _grid[1][j] == symbol && _grid[2][j] == symbol) {
        return true;
      }
    }
    
    // Diagonales
    if (_grid[0][0] == symbol && _grid[1][1] == symbol && _grid[2][2] == symbol) {
      return true;
    }
    if (_grid[0][2] == symbol && _grid[1][1] == symbol && _grid[2][0] == symbol) {
      return true;
    }
    
    return false;
  }
  
  void reset() {
    _grid = List.generate(_size, (_) => List.filled(_size, ' '));
  }
}