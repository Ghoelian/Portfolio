int[][] field = new int[4][4];
int gridSizeX;
int gridSizeY;

boolean hasMerged = false;

void setup() {
  size(600, 600);

  gridSizeX = width / field.length;
  gridSizeY = height / field[0].length;

  for (int i = 0; i < field.length; i++) {
    for (int j = 0; j < field[0].length; j++) {
      field[i][j] = 0;
    }
  }

  randomTile();
  randomTile();
}

void draw() {
  background(52);
  drawNumbers();
  drawGrid();
}

void drawGrid() {
  for (int i = 1; i < field.length; i++) {
    line(i * gridSizeX, 0, i * gridSizeX, height);
  }

  for (int i = 1; i < field[0].length; i++) {
    line(0, i * gridSizeY, width, i * gridSizeY);
  }
}

void drawNumbers() {
  for (int i = 0; i < field.length; i++) {
    for (int j = 0; j < field[0].length; j++) {
      if (field[i][j] != 0) {
        fill(255, 0, 0);
        rect(i * gridSizeX, j * gridSizeY, gridSizeX, gridSizeY);

        fill(0);
        textSize(56);
        textAlign(LEFT, TOP);
        text(field[i][j], i * gridSizeX, j * gridSizeY);
      }
    }
  }
}

void randomTile() {
  int x = int(random(4));
  int y = int(random(4));

  if (field[x][y] == 0) {
    field[x][y] = 2;
  } else {
    randomTile();
  }
}

void keyPressed() { //<>//
  if (keyCode == 37) { // LEFT //<>//
    for (int k = 0; k < 4; k++) { //<>//
      for (int i = 0; i < field.length - 1; i++) { //<>//
        for (int j = 0; j < field[0].length; j++) { //<>//
          if (field[i][j] == 0) { //<>//
            field[i][j] = field[i + 1][j]; //<>//
            field[i + 1][j] = 0; //<>//
          } //<>//

          if (field[i][j] == field[i + 1][j] && hasMerged == false) { //<>//
            field[i][j] = field[i][j] + field[i + 1][j];   //<>//
            field[i + 1][j] = 0; //<>//

            hasMerged = true; //<>//
          } //<>//
        } //<>//
      } //<>//
      hasMerged = false; //<>//
    } //<>//
    randomTile(); //<>//
  } //<>//

  if (keyCode == 38) { // UP
    for (int k = 0; k < 4; k++) {
      for (int i = 0; i < field.length; i++) {
        for (int j = 0; j < field[0].length - 1; j++) {
          if (field[i][j] == 0) {
            field[i][j] = field[i][j + 1];
            field[i][j + 1] = 0;
          }

          if (field[i][j] == field[i][j + 1] && hasMerged == false) {
            field[i][j] = field[i][j] + field[i][j + 1];
            field[i][j + 1] = 0;

            hasMerged = true;
          }
        }
      }
      hasMerged = false;
    }
    randomTile();
  }

  if (keyCode == 39) { // RIGHT
    for (int k = 0; k < 4; k++) {
      for (int i = field.length - 1; i > 0; i--) {
        for (int j = 0; j < field[0].length; j++) {
          if (field[i][j] == 0) {
            field[i][j] = field[i - 1][j];
            field[i - 1][j] = 0;
          }

          if (field[i][j] == field[i - 1][j] && hasMerged == false) {
            field[i][j] = field[i][j] + field[i - 1][j];
            field[i - 1][j] = 0;

            hasMerged = true;
          }
        }
      }
      hasMerged = false;
    }
    randomTile();
  }

  if (keyCode == 40) { // DOWN
    for (int k = 0; k < 4; k++) {
      for (int i = 0; i < field.length; i++) {
        for (int j = field[0].length - 1; j > 0; j--) {
          if (field[i][j] == 0) {
            field[i][j] = field[i][j - 1];
            field[i][j - 1] = 0;
          }

          if (field[i][j] == field[i][j - 1] && hasMerged == false) {
            field[i][j] = field[i][j] + field[i][j - 1];
            field[i][j - 1] = 0;

            hasMerged = true;
          }
        }
      }     
      hasMerged = false;
    }
    randomTile();
  }
}
