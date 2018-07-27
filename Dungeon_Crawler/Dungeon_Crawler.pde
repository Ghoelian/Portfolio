/*
 Nothing = 0,
 Wall = 1,
 Player = 2,
 Enemy = 3,
 Chest = 4,
 Exit = 5
 */

int currentLevel = 1;                            // Keeps track of the current level
int endPosX = 0;                                 // Keeps track of the x/y of the exit of the level
int endPosY = 0;

int[][] level = new int[15][15];                 // Empty array where the level gets copied to then get edited

int[][] level1 = new int[][] {                   // Layout of the levels
  {0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 4}, 
  {0, 0, 0, 3, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1}, 
  {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0}, 
  {0, 0, 0, 1, 4, 0, 1, 4, 0, 0, 1, 0, 0, 0, 0}, 
  {0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 1, 0, 3, 0, 1, 1, 1, 1, 0}, 
  {0, 3, 0, 3, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0}, 
  {1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 3}, 
  {2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0}, 
};

int[][] level2 =  {
  {4, 0, 0, 0, 3, 4, 1, 0, 0, 0, 0, 0, 3, 0, 0}, 
  {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0}, 
  {0, 0, 0, 0, 3, 0, 1, 0, 0, 0, 3, 0, 0, 0, 0}, 
  {1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0}, 
  {4, 0, 1, 0, 0, 0, 3, 0, 0, 1, 0, 0, 1, 0, 0}, 
  {0, 3, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0}, 
  {3, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 3, 1, 0, 0}, 
  {0, 0, 0, 0, 0, 3, 0, 0, 0, 1, 3, 4, 1, 0, 3}, 
  {1, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0}, 
  {0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 5, 1, 0}, 
  {0, 0, 1, 0, 0, 0, 0, 3, 0, 1, 0, 0, 0, 1, 0}, 
  {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0}, 
  {0, 0, 1, 3, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0}, 
  {1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0}, 
  {4, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0}, 
};

int cubeSize;

void setup() {
  size(750, 750);

  cubeSize = width / 15;

  //for (int i = 0; i < cubeSize; i++) {
  //  if (i > 0) {
  //    line(i * cubeSize, 0, i * cubeSize, height);
  //    line(0, i * cubeSize, width, i * cubeSize);
  //  }
  //}

  copyLevel(level1);    // Copies the entire level to an empty array
}

void draw() {
  background(100);
  noStroke();

  showLevel();        // Draws the level on the screen, taken from the 'level' array
}

void copyLevel(int[][] a) {          // Just copies the entire array over to a new array
  for (int i = 0; i < 15; i++) {
    for (int j = 0; j < 15; j++) {
      level[i][j] = a[i][j];
    }
  }
}

void showLevel() {
  for (int i = 0; i < 15; i++) {        // Stores the exit of the level in some variables
    for (int j = 0; j < 15; j++) {
      if (level[i][j] == 5) {
        endPosX = j;
        endPosY = i;
      }

      if (level[i][j] == 1) {          // Draws the walls
        fill(0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 2) {        // Draws the player
        fill(0, 255, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 5) {        // Draws the exit
        fill(255, 255, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 3) {       // Draws the enemies
        fill(255, 0, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 4) {      // Draws the chests
        fill(140, 70, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }
    }
  }
}

/*
 LEFT: 37
 UP: 38
 RIGHT: 39
 DOWN: 40
 */

void keyPressed() {
  int playerPosX = 0;  // Stores the initial player position in level 1, later gets updated when pressing the arrow keys to move
  int playerPosY = 14;

  if (keyCode == 37) {
    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 15; j++) {
        if (level[i][j] == 2) {      // Stores the current player pos into the variables
          playerPosX = j;
          playerPosY = i;
        }
      }
    }

    if (playerPosX != 0) {        // Checks if the player isn't next to a wall on the left side
      if (level[playerPosY][playerPosX - 1] != 1) { // Checks if the space the player is trying to move to (to the left in this case) isn't a wall
        level[playerPosY][playerPosX - 1] = 2;      // Updates the player's position
        level[playerPosY][playerPosX] = 0;

        playerPosX -= 1;
      }
    }
  }

  if (keyCode == 38) {            // Same as above, but for moving up
    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 15; j++) {
        if (level[i][j] == 2) {
          playerPosX = j;
          playerPosY = i;
        }
      }
    }

    if (playerPosY != 0) {
      if (level[playerPosY - 1][playerPosX] != 1) {
        level[playerPosY - 1][playerPosX] = 2;
        level[playerPosY][playerPosX] = 0;

        playerPosY -= 1;
      }
    }
  }

  if (keyCode == 39) {        // Same as above, but for moving right
    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 15; j++) {
        if (level[i][j] == 2) {
          playerPosX = j;
          playerPosY = i;
        }
      }
    }

    if (playerPosX != 14) {
      if (level[playerPosY][playerPosX + 1] != 1) {
        level[playerPosY][playerPosX + 1] = 2;
        level[playerPosY][playerPosX] = 0;

        playerPosX += 1;
      }
    }
  }

  if (keyCode == 40) {          // Same as above, but for moving down
    for (int i = 0; i < 15; i++) {
      for (int j = 0; j < 15; j++) {
        if (level[i][j] == 2) {
          playerPosX = j;
          playerPosY = i;
        }
      }
    }

    if (playerPosY != 14) {
      if (level[playerPosY + 1][playerPosX] != 1) {
        level[playerPosY + 1][playerPosX] = 2;
        level[playerPosY][playerPosX] = 0;
        playerPosY += 1;
      }
    }
  }

  if (playerPosX == endPosX && playerPosY == endPosY) {  // Checks if the player is standing on the exit. If so, move on to the next level
    currentLevel++;

    switch(currentLevel) {
    case 1:
      copyLevel(level1);
    case 2:
      copyLevel(level2);
    }
  }
}
