class Number {
  int colsize = 15;
  float y = random(-height*2, -height);
  float yspeed = random(3, 6);
  int amount = (int) random(4, 30);
  int rows = width/colsize;
  float x = random(rows);
  
  void fall() {
    y = y + yspeed;

    if (y > height) {
      y = random(-700, -300);
    }
  }

  void show() {
    int green = 0;
    
    for (int i = 0; i < amount; i++) {
      int number = (int) random(2);
      
      fill(0, green, 0);
      text(number, x * colsize, y + i * colsize);
      green += random(10, 50);
    }
  }
}
