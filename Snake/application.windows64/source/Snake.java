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

public class Snake extends PApplet {

int windowWidth = 600;
int windowHeight = 600;

int cubeSize = 20;

int playerLength = 5;
int snakeLength = 3;

int playerX = 14;
int playerY = 15;

int fruitX;
int fruitY;

ArrayList<Integer> tailPosX = new ArrayList<Integer>();
ArrayList<Integer> tailPosY = new ArrayList<Integer>();

int rows = windowHeight/cubeSize;
int cols = windowWidth/cubeSize;

int dir = 3; //UP: 1, RIGHT: 2, DOWN: 3, LEFT: 4

int time = 0;

int score = 0;

public void setup() {
  

  for (int i = 0; i < 3; i++) {
    tailPosX.add(14);
  }

  tailPosY.add(14);
  tailPosY.add(13);
  tailPosY.add(12);
}

public void draw() {
  frame.setAlwaysOnTop(true);
  background(52);
  time += 1;

  //for (int i = 0; i < cols; i ++) {
  //  if (i >= 1) {
  //    stroke(255);
  //    line(i*cubeSize, 0, i*cubeSize, height);
  //  }
  //}

  //for (int j = 0; j < rows; j++) {
  //  if (j >= 1) {
  //    stroke(255);
  //    line(0, j*cubeSize, width, j*cubeSize);
  //  }
  //}

  showPlayer();
  movePlayer();
  drawFruit();
  addFruit();

  fill(255);
  textSize(30);
  text(score, 0, 25);

  if (gameOver()) {
    fill(255, 0, 0);
    textSize(32);
    text("Game Over", width/2-80, height/2);
    textSize(19);
    text("Press 'R' to restart", width/2-80, height/2+20);
    noLoop();
  }
}

public void keyPressed() {
  //W: 87, A: 65, S: 83, D: 68, R:
  if (keyCode == 87 && dir != 3) {
    dir = 1;
  } else if (keyCode == 65 && dir != 2) {
    dir = 4;
  } else if (keyCode == 83 && dir != 1) {
    dir = 3;
  } else if (keyCode == 68 && dir != 4) {
    dir = 2;
  } else if (keyCode == 82 && gameOver()) {
    restart();
  }
}

public void movePlayer() {
  if (time%6 == 0) {   
    for (int i = snakeLength-1; i >= 0; i--) {
      if (i == 0) {
        tailPosX.set(i, playerX);
        tailPosY.set(i, playerY);
      } else {
        tailPosX.set(i, tailPosX.get(i-1));
        tailPosY.set(i, tailPosY.get(i-1));
      }
    }

    if (dir == 1) {     
      playerY -= 1;
    } else if (dir == 2) {
      playerX += 1;
    } else if (dir == 3) {
      playerY += 1;
    } else if (dir == 4) {
      playerX -= 1;
    }
  }
}

public void showPlayer() {
  for (int i = 0; i < snakeLength; i++) { //Tail
    stroke(0);
    fill(0, 255, 0);
    rect(tailPosX.get(i)*cubeSize, tailPosY.get(i)*cubeSize, cubeSize, cubeSize);
  }

  fill(0, 255, 0);
  rect(playerX*cubeSize, playerY*cubeSize, cubeSize, cubeSize);
}

public void addFruit() {
  if (fruitGot() || time == 1) {
    float fruitXfloat = random(cols-1);
    float fruitYfloat = random(rows-1);


    fruitX = PApplet.parseInt(fruitXfloat);
    fruitY = PApplet.parseInt(fruitYfloat);

    if (fruitX == playerX && fruitY == playerY) {
      addFruit();
    }
    for (int i = 0; i < snakeLength; i ++) {
      if (fruitX == tailPosX.get(i) && fruitY == tailPosY.get(i)) {
        addFruit();
      }
    }
  }
}

public void drawFruit() {
  fill(255, 0, 0);
  ellipse((fruitX*cubeSize)+cubeSize/2, (fruitY*cubeSize)+cubeSize/2, cubeSize, cubeSize);
}

public boolean fruitGot() {
  if (playerX == fruitX && playerY == fruitY) {
    tailPosX.add(snakeLength, tailPosX.get(snakeLength-1)-cubeSize);
    tailPosY.add(snakeLength, tailPosY.get(snakeLength-1)-cubeSize);

    snakeLength += 1;
    score += 1;
    return true;
  }
  return false;
}

public boolean gameOver() {
  for (int i = 0; i < snakeLength; i++) {
    if (tailPosX.get(i) == playerX && tailPosY.get(i) == playerY) {
      return true;
    }
  }

  if (playerX*cubeSize >= width || playerX*cubeSize < 0 || playerY*cubeSize >= height || playerY*cubeSize < 0) {
    return true;
  } else {
    return false;
  }
}

public void restart() {
  loop();

  score = 0;
  playerX = 14;
  playerY = 15;
  fruitX = 0;
  fruitY = 0;
  dir = 3;
  snakeLength = 3;

  for (int i = 0; i < tailPosX.size(); i++) {
    tailPosX.remove(i);
    tailPosY.remove(i);
  }

  for (int i = 0; i < 3; i++) {
    tailPosX.add(14);
  }

  tailPosY.add(14);
  tailPosY.add(13);
  tailPosY.add(12);
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Snake" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
