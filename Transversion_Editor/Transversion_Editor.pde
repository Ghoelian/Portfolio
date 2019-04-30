int gridSize = 26;
int rows = 20;
int cols = 31;

boolean drawPellet = false;
boolean removePellet = false;


int[][] level = new int[31][20];

void setup() {
  size(780, 494);

  for (int i = 0; i < level.length; i++) {
    for (int j = 0; j < level[0].length; j++) {
      level[i][j] = 0;
    }
  }
}

void drawGrid() { // Draws a grid
  for (int i = 0; i < cols; i++) {
    if (i > 0) {
      line((i * gridSize) - gridSize / 2, 0, (i * gridSize) - gridSize / 2, height);
    }
  }

  for (int i = 0; i < rows; i++) {
    if (i > 0) {
      line(0, (i * gridSize) - gridSize / 2, width, (i * gridSize) - gridSize / 2);
    }
  }
}

void drawPellets() {
  for (int i = 0; i < level.length; i++) {
    for (int j = 0; j < level[0].length; j++) {
      if (level[i][j] == 1) {
        fill(0, 180, 255);
        rectMode(CENTER);
        rect(i * gridSize + (gridSize / 2), j * gridSize + (gridSize / 2), 15, 15);
      }
    }
  }
}

void draw() {
  background(150);

  drawGrid();
  drawPellets();

  if (drawPellet) {
    drawPellet();
  }

  if (removePellet) {
    removePellet();
  }

  rectMode(CENTER);
  fill(255, 0, 0);
  rect(width / 2, height / 2, 15, 15);
}

void keyPressed() {
  if (keyCode == 10) {
    for (int i = 0; i < level.length; i++) {
      print("{");

      for (int j = 0; j < level[0].length; j++) {
        if (j < level[0].length - 1) {
          print(level[i][j] + ", ");
        } else {
          print(level[i][j]);
        }
      }

      print("},\n");
    }

    print("\n");
  }
}

void mousePressed() {
  if (mouseButton == LEFT) {
    drawPellet = true;
  } else if (mouseButton == RIGHT) {
    removePellet = true;
  }
}

void mouseReleased() {
  if (drawPellet) {
    drawPellet = !drawPellet;
  }

  if (removePellet) {
    removePellet = !removePellet;
  }
}

void drawPellet() {
  int x = mouseX / gridSize;
  int y = mouseY / gridSize;

  if (x >= 0 && y >= 0 && x <= 30 && y <= 19) {
    level[x][y] = 1;
  }
}

void removePellet() {
  int x = mouseX / gridSize;
  int y = mouseY / gridSize;

  if (x >= 0 && y >= 0 && x <= 30 && y <= 19) {
    level[x][y] = 0;
  }
}
