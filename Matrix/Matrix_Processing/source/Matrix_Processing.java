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

public class Matrix_Processing extends PApplet {

Number[] numbers = new Number[500];

public void setup() {
  

  for (int i = 0; i < numbers.length; i++) {
    numbers[i] = new Number();
  }
}

public void draw() {
  background(0);
  
  for (int i = 0; i < numbers.length; i++) {
    numbers[i].show();
    numbers[i].fall();
  }
}
class Number {
  int colsize = 15;
  float y = random(-height*2, -height);
  float yspeed = random(3, 6);
  int amount = (int) random(4, 30);
  int rows = width/colsize;
  float x = random(rows);
  
  public void fall() {
    y = y + yspeed;

    if (y > height) {
      y = random(-700, -300);
    }
  }

  public void show() {
    int green = 0;
    
    for (int i = 0; i < amount; i++) {
      int number = (int) random(2);
      
      fill(0, green, 0);
      text(number, x * colsize, y + i * colsize);
      green += random(10, 50);
    }
  }
}
  public void settings() {  fullScreen(); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Matrix_Processing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
