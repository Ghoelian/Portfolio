int gridSize = 26;
int rows = 20;
int cols = 31;
int playerX = 14;
int playerY = 10;
int timer = 0;
int playerDir = 1;
PImage player;
PImage enemy;

void setup() {
  size(780, 494);

  player = loadImage("player.png");
  enemy = loadImage("enemy.png");
}

void draw() {
  timer += 1;
  background(100);

  drawGrid();
  movePlayer();
  showPlayer();
}

void keyPressed() {
  if (keyCode == 38) {          //UP
    playerDir = 1;
  } else if (keyCode == 39) {   //RIGHT
    playerDir = 2;
  } else if (keyCode == 40) {   //DOWN
    playerDir = 3;
  } else if (keyCode == 37) {   //LEFT
    playerDir = 4;
  }
}

void drawGrid() {
  for (int i = 0; i < cols; i++) {
    if (i > 0) {
      line((i * gridSize)-gridSize/2, 0, (i * gridSize) - gridSize/2, height);
    }
  }

  for (int i = 0; i < rows; i++) {
    if (i > 0) {
      line(0, (i*gridSize)-gridSize/2, width, (i*gridSize)-gridSize/2);
    }
  }
}

void movePlayer() {
  if (timer % 10 == 0) {
    if (playerDir == 1 && playerY * gridSize > gridSize * 2) {
      playerY -= 1;
    } else if (playerDir == 3 && playerY * gridSize < height - gridSize) {
      playerY += 1;
    } else if (playerDir == 2 && playerX * gridSize < width - gridSize) {
      playerX += 1;
    } else if (playerDir == 4 && playerX * gridSize > gridSize * 2) {
      playerX -= 1;
    }
  }
}

void showPlayer() {
  imageMode(CENTER);
  pushMatrix();
  translate((playerX * gridSize) - (gridSize/2), (playerY * gridSize) - (gridSize/2));

  if (playerDir == 1) {
    rotate(radians(0));
  } else if (playerDir == 2) {
    rotate(radians(90));
  } else if (playerDir == 3) {
    rotate(radians(180));
  } else if (playerDir == 4) {
    rotate(radians(270));
  }

  image(player, 0, 0, gridSize, gridSize);
  popMatrix();
}

void shooterA() {
}

void shooterB() {
}

void shooterC() {
}

void shooterD() {
}
