class Number {
  int cols = width / 10;
  int rows = height / 15;
  int numbers[][];

  void prepare() {
    numbers = new int[cols][rows];
  }

  void show() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        int number = (int) random(2);
        numbers[i][j] = number;
      }
    }

    for (int i = 0; i < cols; i++) {
      int colour = 0;

      for (int j = 0; j < rows; j++) {
        fill(0, colour, 0);
        text(numbers[i][j], i * 10, j * 15);
        colour += 10;
      }
    }
  }
}
