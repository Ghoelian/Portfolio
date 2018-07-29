import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class match4_Processing extends PApplet {

int[][] tiles = new int[8][8];
int a;
int turn = 1;
boolean gameOver = false;

public void setup() {
  

  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      tiles[i][j] = 0;
    }
  }
}

public void draw() {
  a = width / 8;
  background(200);

  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (tiles[i][j] == 1) {
        fill(0, 0, 255);
        rect(i * a, j * a, a, a);
      } else if (tiles[i][j] == 2) {
        fill(0, 255, 0);
        rect(i * a, j * a, a, a);
      }
    }
  }

  for (int i = 1; i < 8; i++) {
    line(i * a, 0, i * a, height);
    line(0, i * a, width, i * a);
  }

  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (i < 5) {
        if (tiles[i][j] == 1 && tiles[i + 1][j] == 1 && tiles[i + 2][j] == 1 && tiles[i + 3][j] == 1) {
          gameOver(1);
        }

        if (tiles[i][j] == 2 && tiles[i + 1][j] == 2 && tiles[i + 2][j] == 2 && tiles[i + 3][j] == 2) {
          gameOver(2);
        }
      }

      if (j < 5) {
        if (tiles[i][j] == 1 && tiles[i][j + 1] == 1 && tiles[i][j + 2] == 1 && tiles[i][j + 3] == 1) {
          gameOver(1);
        }

        if (tiles[i][j] == 2 && tiles[i][j + 1] == 2 && tiles[i][j + 2] == 2 && tiles[i][j + 3] == 2) {
          gameOver(2);
        }
      }

      if (i <= 4 && j <= 4) {
        if (tiles[i][j] == 1 && tiles[i + 1][j + 1] == 1 && tiles[i + 2][j + 2] == 1 && tiles[i + 3][j + 3] == 1) {
          gameOver(1);
        }

        if (tiles[i][j] == 2 && tiles[i + 1][j + 1] == 2 && tiles[i + 2][j + 2] == 2 && tiles[i + 3][j + 3] == 2) {
          gameOver(2);
        }
      }

      if (i >= 3 && j <= 4) {
        if (tiles[i][j] == 1 && tiles[i - 1][j + 1] == 1 && tiles[i - 2][j + 2] == 1 && tiles[i - 3][j + 3] == 1) {
          gameOver(1);
        }

        if (tiles[i][j] == 2 && tiles[i - 1][j + 1] == 2 && tiles[i - 2][j + 2] == 2 && tiles[i - 3][j + 3] == 2) {
          gameOver(2);
        }
      }
    }
  }
}

public void mousePressed() {
  int mouse = mouseX / a;

  for (int i = 7; i >= 0; i--) {
    if (tiles[mouse][i] == 0 && gameOver == false) {
      tiles[mouse][i] = turn;

      if (turn == 1) {
        turn = 2;
      } else if (turn == 2) {
        turn = 1;
      }

      break;
    }
  }
}

public void gameOver(int player) {
  textSize(40);
  fill(0);
  textAlign(CENTER);
  text("Player " + player + " has won!", width/2, height/2);
  gameOver = true;
}

public void keyPressed() {
  if (keyCode == 82 && gameOver == true) {
    gameOver = false;
    reset();
  }
}

public void reset() {
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      tiles[i][j] = 0;
    }
  }
}
  public void settings() {  size(400, 400); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "match4_Processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
