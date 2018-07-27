int cubeSize;
int[][] level = new int[][] {
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
};

void setup() {
  size(750, 750);

  cubeSize = width / 15;
}
void draw() {
  background(150);

  for (int i = 0; i < cubeSize; i++) {
    if (i > 0) {
      line(i * cubeSize, 0, i * cubeSize, height);
      line(0, i * cubeSize, width, i * cubeSize);
    }
  }

  for (int i = 0; i < 15; i++) {
    for (int j = 0; j < 15; j++) {
      if (level[i][j] == 1) {
        fill(0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 2) {
        fill(0, 255, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 5) {
        fill(255, 255, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 3) {
        fill(255, 0, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 4) {
        fill(140, 70, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }
    }
  }
}

/*
 65 A: Wall
 70 F: Player
 68 D: Enemy
 83 S: Chest
 71 G: Exit
 32  : Erase
 */

void keyPressed() {
  int x = mouseX / cubeSize;
  int y = mouseY / cubeSize;

  if (keyCode == 65) {
    level[y][x] = 1;
  }

  if (keyCode == 70) {
    level[y][x] = 2;
  }

  if (keyCode == 68) {
    level[y][x] = 3;
  }

  if (keyCode == 83) {
    level[y][x] = 4;
  }

  if (keyCode == 71) {
    level[y][x] = 5;
  }

  if (keyCode == 32) {
    level[y][x] = 0;
  }

  if (keyCode == 10) {
    for (int i = 0; i < 15; i++) {
      print("{");

      for (int j = 0; j < 15; j++) {
        if (j < 14) {
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
