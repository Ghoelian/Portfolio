class Graph {
  void drawPoints() {
    pg.noStroke();
    pg.ellipseMode(CORNER);

    for (int i = 0; i < grid.length; i++) {
      for (int j = 0; j < grid[0].length; j++) {
        if (grid[i][j] == true) {
          pg.fill(getColour(i, j));
          pg.ellipse((i * gridSize) + xOffset + 2, (j * gridSize) + yOffset, gridSize, gridSize);
        }
      }
    }
  }

  color getColour(int i, int j) {
    colorMode(HSB);
    int hue = i * j;
    float upperLimit = grid.length * grid.length;
    float mappedHue = map(hue, 0, upperLimit, 0, 255);
    color colour = color(mappedHue, 255, 255);
    return colour;
  }
}
