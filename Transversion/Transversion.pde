int gridSize = 26;
int rows = 20;
int cols = 31;
int timer = 0;

int playerX = 14;
int playerY = 10;
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
int bulletDposX = 0;

int bulletAposY = 0;
int bulletBposY = 0;
int bulletCposY = 0;
int bulletDposY = 0;

int speed = 10;

boolean canMove = true;

boolean shooterAhasShot = false;
boolean shooterBhasShot = false;
boolean shooterChasShot = false;
boolean shooterDhasShot = false;

boolean bulletAmove = false;
boolean bulletBmove = false;
boolean bulletCmove = false;
boolean bulletDmove = false;

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
  text(shooterApos, 0, 10);
  text(playerX, 0, 20);
  text(temp, 40, 10);

  if (shooterApos == playerX) {
    shoot("A");
    temp++;
  } else if (shooterBpos == playerY) {
    shoot("B");
  } else if (shooterCpos == playerX) {
    shoot("C");
  } else if (shooterDpos == playerY) {
    shoot("D");
  }

  movePlayer();
  showPlayer();

  moveShooter();
  showShooter();

  bulletMove();



  if (timer % speed == 0) {
    canMove = true;
  }

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
    shooterAhasShot = false;
  } else if (shooterApos <= 2) {
    shooterAdir = 1;
    shooterAhasShot = false;
  }

  if (shooterBpos >= rows - 2) {
    shooterBdir = 2;
    shooterBhasShot = false;
  } else if (shooterBpos <= 2) {
    shooterBdir = 1;
    shooterBhasShot = false;
  }

  if (shooterCpos >= cols - 2) {
    shooterCdir = 2;
    shooterChasShot = false;
  } else if (shooterCpos <= 2) {
    shooterCdir = 1;
    shooterChasShot = false;
  }

  if (shooterDpos >= rows - 2) {
    shooterDdir = 2;
    shooterDhasShot = false;
  } else if (shooterDpos <= 2) {
    shooterDdir = 1;
    shooterDhasShot = false;
  }

  if (timer % speed == 0) {  
    if (shooterAdir == 1) {
      shooterApos++;
    } else if (shooterAdir == 2) {
      shooterApos--;
    }

    if (shooterBdir == 1) {
      shooterBpos++;
    } else if (shooterBdir == 2) {
      shooterBpos--;
    }

    if (shooterCdir == 1) {
      shooterCpos++;
    } else if (shooterCdir == 2) {
      shooterCpos--;
    }

    if (shooterDdir == 1) {
      shooterDpos++;
    } else if (shooterDdir == 2) {
      shooterDpos--;
    }
  }
}

void shoot(String x) {
  switch(x) {
  case "A":
    if (shooterAhasShot == false) {
      bulletAposX = shooterApos;
      bulletAmove = true;
      shooterAhasShot = true;
    }
  case "B":
    if (shooterBhasShot == false) {
      bulletBposY = shooterBpos;
      bulletBmove = true;
      shooterBhasShot = true;
    }
  case "C":
    if (shooterChasShot == false) {
      bulletCposX = shooterCpos;
      bulletCmove = true;
      shooterChasShot = true;
    }
  case "D":
    if (shooterDhasShot == false) {
      bulletDposY = shooterDpos;
      bulletDmove = true;
      shooterDhasShot = true;
    }
  }
}

void bulletMove() {
  if (bulletAmove == true) {
    ellipseMode(CENTER);
    ellipse((bulletAposX * gridSize) - (gridSize / 2), (bulletAposY * gridSize) - (gridSize / 2), gridSize, gridSize);

    if (timer % speed == 0) {
      bulletAposY++;
    }

    if (bulletAposY >= rows) {
      bulletAmove = false;
    }
  }
}
