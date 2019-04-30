int cubeSize = 40; //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>// //<>//
int cols = 15;
int rows = 9;

int playerX = 4;
int playerY = 4;

int[] wallX = new int[28];
int[] wallY = new int[28];

boolean moveUp = false;
boolean moveDown = false;
boolean moveLeft = false;
boolean moveRight = false;

boolean[][] wallPos = new boolean[28][28];

void setup() {
  size(600, 360);
}

void draw() {
  background(200);

  wall();

  for (int i = 0; i < cols; i++) {
    if (i > 0) {
      line(i*cubeSize, 0, i*cubeSize, height);
    }
  }

  for (int i = 0; i < rows; i++) {
    if (i > 0) {
      line(0, i*cubeSize, width, i*cubeSize);
    }
  }

  showPlayer();
  collision();
}

void showPlayer() {
  fill(0);
  rect(playerX*cubeSize, playerY*cubeSize, cubeSize, cubeSize);
}

void keyPressed() {
  //W: 87, A: 65, S: 83, D: 68, R: 82, UP: 38, LEFT: 37, DOWN: 40, RIGHT: 39
  if (keyCode == 87 || keyCode == 38) {   
    if (playerY*cubeSize > 0 && moveUp == true) {
      playerY -= 1;
    }
  } else if (keyCode == 65 || keyCode == 37) {
    if (playerX*cubeSize > 0 && moveLeft == true) {
      playerX -= 1;
    }
  } else if (keyCode == 83 || keyCode == 40) {
    if (playerY*cubeSize < height-cubeSize && moveRight == true) {
      playerY += 1;
    }
  } else if (keyCode == 68 || keyCode == 39) {
    if (playerX*cubeSize < width-cubeSize && moveDown == true) {
      playerX += 1;
    }
  }
}

void wall() {
  int counter = 0;

  for (int i = 0; i < cols; i++) {
    if (i % 2 == 1) {      
      for (int j = 0; j < rows; j++) {
        if (j % 2 == 1) {
          wallPos[i][j] = true;
          counter++;

          fill(100);
          rect(i*cubeSize, j*cubeSize, cubeSize, cubeSize);
        }
      }
    }
  }
}

void collision() {
  for (int i = 0; i < wallX.length; i++) { //<>//
    for(int j = 0; j < wallY.length; j++) {
      if(i == playerX && j == playerY && wallPos[i-1][j] == true) {
        moveDown = false;
      }
      if(i == playerX && j == playerY && wallPos[i+1][j] == true) {
        moveUp = false;
      }
      if(i == playerX && j == playerY && wallPos[i][j-1] == true) {
        moveRight = false;
      }
      if(i == playerX && j == playerY && wallPos[i][j+1] == true) {
        moveLeft = false;
      }
      
      if(i == playerX && j == playerY && wallPos[i-1][j] == false) {
        moveDown = true;
      }
      if(i == playerX && j == playerY && wallPos[i+1][j] == false) {
        moveUp = true;
      }
      if(i == playerX && j == playerY && wallPos[i][j-1] == false) {
        moveRight = true;
      }
      if(i == playerX && j == playerY && wallPos[i][j+1] == false) {
        moveLeft = true;
      }
    }
  }
}