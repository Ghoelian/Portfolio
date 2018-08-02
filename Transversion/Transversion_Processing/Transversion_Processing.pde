int gridSize = 26;
int rows = 20;
int cols = 31;
int timer = 0;

int playerX = 12;
int playerY = 12;
int playerDir = 1;
int playerRotation = 0;

int temp = 0;

int shooterApos = 14;
int shooterBpos = 10;
int shooterCpos = 14;
int shooterDpos = 10;

int shooterAdir = 1;
int shooterBdir = 1;
int shooterCdir = 2;
int shooterDdir = 2;

int bulletAposX = 0;
int bulletBposX = 0;
int bulletCposX = 0;
int bulletDposX = cols;

int bulletAposY = 0;
int bulletBposY = 0;
int bulletCposY = rows;
int bulletDposY = 0;

int lives = 4;

int speed = 10;

boolean canMove = true;

boolean shooterAcanMove = true;
boolean shooterBcanMove = true;
boolean shooterCcanMove = true;
boolean shooterDcanMove = true;

boolean shooterAhasShot = false;
boolean shooterBhasShot = false;
boolean shooterChasShot = false;
boolean shooterDhasShot = false;

boolean bulletAmove = false;
boolean bulletBmove = false;
boolean bulletCmove = false;
boolean bulletDmove = false;

boolean bulletAshot = false;
boolean bulletBshot = false;
boolean bulletCshot = false;
boolean bulletDshot = false;

PImage player;
PImage shooter;

void setup() {
  size(780, 494);

  player = loadImage("player.png");
  shooter = loadImage("enemy.png");
}

void draw() {  
  background(100);

  drawGrid();

  if (shooterApos == playerX && shooterAcanMove == true) {
    shoot("A");
  } else if (shooterApos + 1 == playerX && shooterAcanMove == true) {
    shooterApos++;
    shoot("A");
  } else if (shooterApos - 1 == playerX && shooterAcanMove == true) {
    shooterApos--;
    shoot("A");
  }

  if (shooterBpos == playerY && shooterBcanMove == true) {
    shoot("B");
  } else if (shooterBpos + 1 == playerY && shooterBcanMove == true) {
    shooterBpos++;
    shoot("B");
  } else if (shooterBpos - 1 == playerY && shooterBcanMove == true) {
    shooterBpos--;
    shoot("B");
  }

  if (shooterCpos == playerX && shooterCcanMove == true) {
    shoot("C");
  } else if (shooterCpos + 1 == playerX && shooterCcanMove == true) {
    shooterCpos++;
    shoot("C");
  } else if (shooterCpos - 1 == playerX && shooterCcanMove == true) {
    shooterCpos--;
    shoot("C");
  }

  if (shooterDpos == playerY && shooterDcanMove == true) {
    shoot("D");
  } else if (shooterDpos + 1 == playerY && shooterDcanMove == true) {
    shooterDpos++;
    shoot("D");
  } else if (shooterDpos - 1 == playerY && shooterDcanMove == true) {
    shooterDpos--;
    shoot("D");
  }

  movePlayer();
  showPlayer();

  moveShooter();
  showShooter();

  bulletMove();
  shooting();


  if (timer % speed == 0) {
    canMove = true;
  }
  
  text(lives, 0, 10);

  timer += 1;
}

void keyPressed() {
  if (canMove == true) {
    if (keyCode == 38 && playerDir != 3) {          //UP
      playerDir = 1;
    } else if (keyCode == 39 && playerDir != 4) {   //RIGHT
      playerDir = 2;
    } else if (keyCode == 40 && playerDir != 1) {   //DOWN
      playerDir = 3;
    } else if (keyCode == 37 && playerDir != 2) {   //LEFT
      playerDir = 4;
    }

    canMove = false;
  }
}

void drawGrid() {                            // Draws a grid
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

void movePlayer() {                              // Moves the player in the right direction
  if (timer % speed == 0) {
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
  imageMode(CENTER);            // Draws the image form the center point, instead of the upper left corner
  pushMatrix();                 // Don't know what this does, but according to the internet it's necessary here
  translate((playerX * gridSize) - (gridSize/2), (playerY * gridSize) - (gridSize/2));  // Translates to the player's x and y coordinates

  if (timer % speed == 0) {
    if (playerDir == 1) {          // Rotates the player image according to it's current direction
      playerRotation = 0;
    } else if (playerDir == 2) {
      playerRotation = 90;
    } else if (playerDir == 3) {
      playerRotation = 180;
    } else if (playerDir == 4) {
      playerRotation = 270;
    }
  }

  rotate(radians(playerRotation));
  image(player, 0, 0, gridSize, gridSize);        // Draws the player image on screen
  popMatrix();
}

void showShooter() {
  imageMode(CENTER);
  pushMatrix();
  translate((shooterApos * gridSize) - (gridSize / 2), gridSize / 2);
  rotate(radians(180));
  image(shooter, 0, 0, gridSize, gridSize);
  popMatrix();

  imageMode(CENTER);
  pushMatrix();
  translate(gridSize / 2, (shooterBpos * gridSize) - (gridSize / 2));
  rotate(radians(90));
  image(shooter, 0, 0, gridSize, gridSize);
  popMatrix();

  imageMode(CENTER);
  pushMatrix();
  translate((shooterCpos * gridSize) - (gridSize / 2), height - (gridSize / 2));
  rotate(radians(0));
  image(shooter, 0, 0, gridSize, gridSize);
  popMatrix();

  imageMode(CENTER);
  pushMatrix();
  translate(width - (gridSize / 2), (shooterDpos * gridSize) - (gridSize / 2));
  rotate(radians(270));
  image(shooter, 0, 0, gridSize, gridSize);
  popMatrix();
}

void moveShooter() {
  if (shooterApos >= cols - 2) {
    shooterAdir = 2;
  } else if (shooterApos <= 2) {
    shooterAdir = 1;
  }

  if (shooterBpos >= rows - 2) {
    shooterBdir = 2;
  } else if (shooterBpos <= 2) {
    shooterBdir = 1;
  }

  if (shooterCpos >= cols - 2) {
    shooterCdir = 2;
  } else if (shooterCpos <= 2) {
    shooterCdir = 1;
  }

  if (shooterDpos >= rows - 2) {
    shooterDdir = 2;
  } else if (shooterDpos <= 2) {
    shooterDdir = 1;
  }

  if (timer % speed == 0) {  
    if (shooterAcanMove == true) {
      if (shooterAdir == 1) {
        shooterApos++;
      } else if (shooterAdir == 2) {
        shooterApos--;
      }
    }

    if (shooterBcanMove == true) {
      if (shooterBdir == 1) {
        shooterBpos++;
      } else if (shooterBdir == 2) {
        shooterBpos--;
      }
    }

    if (shooterCcanMove == true) {
      if (shooterCdir == 1) {
        shooterCpos++;
      } else if (shooterCdir == 2) {
        shooterCpos--;
      }
    }

    if (shooterDcanMove == true) {
      if (shooterDdir == 1) {
        shooterDpos++;
      } else if (shooterDdir == 2) {
        shooterDpos--;
      }
    }
  }
}

void shoot(String x) {
  if (x == "A") {
    if (shooterAhasShot == false) {
      bulletAshot = true;
      shooterAhasShot = true;
    }
  }

  if (x == "B") {
    if (shooterBhasShot == false) {
      bulletBshot = true;
      shooterBhasShot = true;
    }
  }

  if (x == "C") {
    if (shooterChasShot == false) {
      bulletCshot = true;
      shooterChasShot = true;
    }
  }

  if (x == "D") {
    if (shooterDhasShot == false) {
      bulletDshot = true;
      shooterDhasShot = true;
    }
  }

  //switch(x) {
  //case "A":
  //  if (shooterAhasShot == false) {
  //    bulletAshot = true;
  //    shooterAhasShot = true;
  //  }
  //case "B":
  //  if (shooterBhasShot == false) {
  //    bulletBshot = true;
  //    shooterBhasShot = true;
  //  }
  //case "C":
  //  if (shooterChasShot == false) {
  //    bulletCshot = true;
  //    shooterChasShot = true;
  //  }
  //case "D":
  //  if (shooterDhasShot == false) {
  //    bulletDshot = true;
  //    shooterDhasShot = true;
  //  }
  //}
}

void shooting() {
  if (bulletAshot == true) {
    bulletAposX = shooterApos;
    bulletAmove = true;
    bulletAshot = false;
    shooterAcanMove = false;
  }

  if (bulletBshot == true) {
    bulletBposY = shooterBpos;
    bulletBmove = true;
    bulletBshot = false;
    shooterBcanMove = false;
  }

  if (bulletCshot == true) {
    bulletCposX = shooterCpos;
    bulletCmove = true;
    bulletCshot = false;
    shooterCcanMove = false;
  }

  if (bulletDshot == true) {
    bulletDposY = shooterDpos;
    bulletDmove = true;
    bulletDshot = false;
    shooterDcanMove = false;
  }

  if (bulletAposX == playerX && bulletAposY == playerY) {
    lives--;
  }

  if (bulletBposX == playerX && bulletBposY == playerY) {
    lives--;
  }

  if (bulletCposX == playerX && bulletCposY == playerY) {
    lives--;
  }

  if (bulletDposX == playerX && bulletDposY == playerY) {
    lives--;
  }
}

void bulletMove() {
  if (bulletAmove == true) {
    ellipseMode(CENTER);
    fill(0, 200, 255);
    ellipse((bulletAposX * gridSize) - (gridSize / 2), (bulletAposY * gridSize) - (gridSize / 2), gridSize / 2, gridSize);

    if (timer % speed == 0) {
      bulletAposY++;
    }

    if (bulletAposY >= rows) {
      bulletAmove = false;
      shooterAhasShot = false;
      shooterAcanMove = true;
      bulletAposY = 0;
    }
  }

  if (bulletBmove == true) {
    ellipseMode(CENTER);
    fill(0, 200, 255);
    ellipse((bulletBposX * gridSize) - (gridSize / 2), (bulletBposY * gridSize) - (gridSize / 2), gridSize, gridSize / 2);

    if (timer % speed == 0) {
      bulletBposX++;
    }

    if (bulletBposX >= cols) {
      bulletBmove = false;
      shooterBhasShot = false;
      shooterBcanMove = true;
      bulletBposX = 0;
    }
  }

  if (bulletCmove == true) {
    ellipseMode(CENTER);
    fill(0, 200, 255);
    ellipse((bulletCposX * gridSize) - (gridSize / 2), (bulletCposY * gridSize) - (gridSize / 2), gridSize / 2, gridSize);

    if (timer % speed == 0) {
      bulletCposY--;
    }

    if (bulletCposY <= 0) {
      bulletCmove = false;
      shooterChasShot = false;
      shooterCcanMove = true;
      bulletCposY = rows;
    }
  }

  if (bulletDmove == true) {
    ellipseMode(CENTER);
    fill(0, 200, 255);
    ellipse((bulletDposX * gridSize) - (gridSize / 2), (bulletDposY * gridSize) - (gridSize / 2), gridSize, gridSize / 2);

    if (timer % speed == 0) {
      bulletDposX--;
    }

    if (bulletDposX <= 0) {
      bulletDmove = false;
      shooterDhasShot = false;
      shooterDcanMove = true;
      bulletDposX = cols;
    }
  }
}
