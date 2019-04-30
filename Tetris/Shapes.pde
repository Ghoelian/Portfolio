class Shape {
  int x = 5;
  int y = 5;


  void i() {
    fill(52);

    rect(x * gridSize, y * gridSize, gridSize, gridSize);
    rect(x * gridSize + gridSize, y * gridSize, gridSize, gridSize);
    rect(x * gridSize + (gridSize * 2), y * gridSize, gridSize, gridSize);
    rect(x * gridSize + (gridSize * 3), y * gridSize, gridSize, gridSize);
    
    if(y >= height / gridSize) {
     
    }
  }

  void j() {
  }

  void l() {
  }

  void o() {
  }

  void s() {
  }

  void t() {
  }

  void z() {
  }

  void move() {
    if (time % 6 == 0) {
      y++;
    }
  }
}
