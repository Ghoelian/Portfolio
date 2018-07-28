/* //<>//
 Nothing = 0,
 Wall = 1,
 Player = 2,
 Enemy = 3,
 Chest = 4,
 Exit = 5
 */

int items = 0;
int currentLevel = 1;                            // Keeps track of the current level
int endPosX = 0;                                 // Keeps track of the x/y of the exit of the level
int endPosY = 0;
int highlighted = 1;        // Keeps track of which option is highlighted in the enemy encounter
boolean enemyEncounter = false;                  // Keeps track of if you're on an enemy encounter
float enemyHealthFloat = ((random(5, 10) + ((currentLevel - 1) * 10)) * 10);    // Gives the enemy a slightly random health
float playerHealthFloat = (1 + ((currentLevel - 1) * 0.8)) * 100;               // Gives the player health based on the level he's on
int playerHealth = floor(playerHealthFloat);    // Floors the player's health
int enemyHealth = floor(enemyHealthFloat);      // Floors the enemy's health
boolean hit = false;                              // Keeps track of if you've hit/missed an attack
boolean miss = false;
boolean runFailed = false;

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

  //for (int i = 0; i < cubeSize; i++) {            // Draws a grid (when uncommented)
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

  if (enemyEncounter == true) {
    enemyEncounter();    // Triggers an enemy encounter
  } else {
    showLevel();        // Draws the level on the screen, taken from the 'level' array
  }
}

void copyLevel(int[][] a) {          // Copies the entire array over to a new array
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

      if (level[i][j] == 3) {       // Draws the enemies
        fill(255, 0, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 4) {      // Draws the chests
        fill(140, 70, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 5) {        // Draws the exit
        fill(255, 255, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }
    }
  }

  textAlign(LEFT);            // Draws how many items you have on screen
  fill(255);
  stroke(0);
  textSize(20);
  text("Items: " + items, 0, height);
}

void enemyEncounter() {
  textAlign(CENTER);

  fill(0, 255, 0);          // Draws the player sprite
  rect(50, 300, 200, 200);

  fill(255, 0, 0);          // Draws the enemy sprite
  rect(500, 100, 200, 200);

  fill(0);                 // Draws the player's/enemy's HP
  textSize(50);
  text(playerHealth, 150, 425);
  text(enemyHealth, width - 150, 225);

  stroke(0);
  noFill();
  rect(5, 550, width - 10, 195, 20);    // Draws the dialogue box

  if (hit == true) {              // Draws the hit/miss text
    fill(0);
    textSize(50);
    text("Hit!", width/2, 625);
  } else if (miss == true) {
    fill(0);
    textSize(50);
    text("Miss!", width/2, 625);
  } else {
    if (highlighted == 1) {        // Draws the fight/item/run text and highlights the selected one
      fill(255);
    } else {
      fill(0);
    }

    textSize(50);
    text("Attack", 100, 625);

    if (highlighted == 2) {
      fill(255);
    } else {
      fill(0);
    }

    text("Item", width - 100, 625);
    textSize(30);
    text("(" + items  + ")", width - 100, 650);

    if (highlighted == 3) {
      fill(255);
    } else {
      fill(0);
    }

    textSize(50);
    text("Run", width / 2, 725);
  }

  if (enemyHealth <= 0) {          // Makes you win when enemy's health <= 0
    background(100);
    fill(255);
    text("You won!", width/2, height/2);

    enemyEncounter = false;
    highlighted = 0;
  } else if (playerHealth <= 0) {          // Makes you lose when player's health <= 0
    background(100);
    fill(255);
    text("You lose!", width/2, height/2);
    textSize(30);
    text("Restart the game to start over", width/2, height/2 + 50);

    noLoop();
  }

  if (runFailed == true) {                // Displays text when you pressed run but it failed
    text("Failed!", width/2, height/2);
  }
}

/*
 LEFT: 37
 UP: 38
 RIGHT: 39
 DOWN: 40
 ENTER: 10
 */

void keyPressed() {
  int playerPosX = 0;  // Stores the initial player position in level 1, later gets updated when pressing the arrow keys to move
  int playerPosY = 14;

  if (enemyEncounter == true) {
    if (highlighted == 1 && keyCode == 39) {      // Moves the highlighted option around in an enemy encounter
      highlighted = 2;
    } else if (highlighted == 2 && keyCode == 37) {
      highlighted = 1;
    } else if (keyCode == 40) {
      highlighted = 3;
    } else if (highlighted == 3 && keyCode == 38) {
      highlighted = 1;
    } else if (highlighted == 3 && keyCode == 37) {
      highlighted = 1;
    } else if (highlighted == 3 && keyCode == 39) {
      highlighted = 2;
    }

    if (hit == true || miss == true) {        // Returns the hit/miss to false once the player presses enter
      hit = false;
      miss = false;
    }

    if (highlighted == 1 && keyCode == 10) {    // Attacks the enemy
      int luck = ceil(random(100));
      int health = ceil(random(15));

      if (luck > 30) {                      // If luck > 30, player hits enemy, else, enemy hits player for a random amount of hp
        enemyHealth -= health;
        hit = true;
        highlighted = 0;
      } else {
        playerHealth -= health;
        miss = true;
        highlighted = 0;
      }
    } else if (highlighted == 2 && items > 0 && keyCode == 10) {      // Uses an item to restore health (if you have one)
      playerHealth += 50;
      items--;
    } else if (highlighted == 3 && keyCode == 10) {                  // Attempts to run
      int luck = ceil(random(100));
      int health = ceil(random(15));

      if (luck > 20) {
        if (runFailed == true) {                          // Restores the runFailed variable back to false if you've already failed to run
          runFailed = false;
        } else {                                          // Ends the enemy encounter, and resets the enemy's health for the next one
          enemyEncounter = false;
          highlighted = 1;

          enemyHealthFloat = ((random(5, 10) + ((currentLevel - 1) * 10)) * 10);
          enemyHealth = floor(enemyHealthFloat);
        }
      } else if (luck <= 20) {
        if (runFailed == true) {                            // Restores the runFailed variable back to false if you've already failed to run
          runFailed = false;
        } else {                                            // Takes some of the player's health if the run failed
          playerHealth -= health;
          
          runFailed = true;                                 // Sets the runFailed variable to true, so that the "Failed" text can appear on screen
        }
      }
    } else if (highlighted == 0) {
      highlighted = 1;
    }

    if (enemyHealth <= 0 && highlighted == 0) {            // Ends the enemy encounter if it's health is <= 0, and resets the enemy's health for the next encounter
      enemyEncounter = false;

      enemyHealthFloat = ((random(5, 10) + ((currentLevel - 1) * 10)) * 10);
      enemyHealth = floor(enemyHealthFloat);
    }
  } else {
    if (hit == true || miss == true) {        // Returns the hit/miss to false once the player presses enter
      hit = false;
      miss = false;

      highlighted = 1;
    }


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
        if (level[playerPosY][playerPosX - 1] == 3) {  // Checks if the space the player wants to move to is an enemy
          enemyEncounter = true;
        } else if (level[playerPosY][playerPosX - 1] == 4) {
          items++;
        }

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
        if (level[playerPosY - 1][playerPosX] == 3) {
          enemyEncounter = true;
        } else if (level[playerPosY - 1][playerPosX] == 4) {
          items++;
        }

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
        if (level[playerPosY][playerPosX + 1] == 3) {
          enemyEncounter = true;
        } else if (level[playerPosY][playerPosX + 1] == 4) {
          items++;
        }

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
        if (level[playerPosY + 1][playerPosX] == 3) {
          enemyEncounter = true;
        } else if (level[playerPosY + 1][playerPosX] == 4) {
          items++;
        }

        if (level[playerPosY + 1][playerPosX] != 1) {
          level[playerPosY + 1][playerPosX] = 2;
          level[playerPosY][playerPosX] = 0;
          playerPosY += 1;
        }
      }
    }
  }


  if (playerPosX == endPosX && playerPosY == endPosY) {  // Checks if the player is standing on the exit. If so, move on to the next level
    currentLevel++;

    playerHealthFloat = (1 + ((currentLevel - 1) * 0.8)) * 100;        // When you get to the next level, health gets reset and increased based on the level you're on
    playerHealth = floor(playerHealthFloat);

    enemyHealthFloat = ((random(5, 10) + ((currentLevel - 1) * 10)) * 10);    // Enemy health also potentially increases on higher floors
    enemyHealth = floor(enemyHealthFloat);

    switch(currentLevel) {
    case 1:
      copyLevel(level1);
    case 2:
      copyLevel(level2);
    }
  }
}
