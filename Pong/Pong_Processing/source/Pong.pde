int p1y;
int p2y;
int speed = 5;
int ySpeed = -5;
int xSpeed = 4;
int ballX;
int ballY;
int p1score = 0;
int p2score = 0;

boolean p1up = false;
boolean p1down = false;
boolean p2up = false;
boolean p2down = false;
boolean ballMove = false;

PFont square;


void setup() {
  size(700, 400);

  square = createFont("square.ttf", 32, true);

  p1y = height/2;
  p2y = height/2;

  ballX = width/2;
  ballY = height/2;
}

void draw() {
  background(200);

  score();
  p1();
  p2();
  ball();
  edges();
}

void p1() {
  rectMode(CENTER);
  fill(255);
  rect(16, p1y, 16, height / 7);

  if (p1up == true && p1y - 30 > 0) {
    p1y -= speed;
  } else if (p1down == true && p1y + 30 < height) {
    p1y += speed;
  }
}

void p2() {
  rectMode(CENTER);
  fill(255);
  rect(width - 16, p2y, 16, height / 7);

  if (p2up == true && p2y - 30 > 0) {
    p2y -= speed;
  } else if (p2down == true && p2y + 30 < height) {
    p2y += speed;
  }
}

void ball() {
  fill(255);
  ellipse(ballX, ballY, 16, 16);

  if (ballMove == true) {
    ballX += xSpeed;
    ballY += ySpeed;
  } else {
    textAlign(CENTER, CENTER);
    fill(0, 0, 0, 255);
    textSize(20);
    text("Press enter to start", width/2, height/4);
  }
}

void edges() {
  if (ballY - 8 <= 0 || ballY + 8 >= height) {
    ySpeed = ySpeed * -1;
  }

  if (ballX - 8 >= width - 40 && ballY >= p2y - 30 && ballY <= p2y + 30 && ballX - 8 <= width - 30) {
    xSpeed = xSpeed * -1;
  }

  if (ballX + 8 <= 40 && ballY >= p1y - 30 && ballY <= p1y + 30 && ballX >= 30) {
    xSpeed = xSpeed * -1;
  }

  if (ballX <= 0) {
    p2score++;
    resetBall();
  }

  if (ballX >= width) {
    p2score++;
    resetBall();
  }
}

void resetBall() {
  ballX = width / 2;
  ballY = height / 2;

  ballMove = false;
}

void keyPressed() {
  if (keyCode == 87) {
    p1up = true;
  } else if (keyCode == 83) {
    p1down = true;
  }

  if (keyCode == 38) {
    p2up = true;
  } else if (keyCode == 40) {
    p2down = true;
  }

  if (keyCode == 10 && ballMove == false) {
    ballMove = true;
  }
}

void keyReleased() {
  if (keyCode == 87) {
    p1up = false;
  } else if (keyCode == 83) {
    p1down = false;
  }

  if (keyCode == 38) {
    p2up = false;
  } else if (keyCode == 40) {
    p2down = false;
  }
}

void score() {
  int textX = height / 2;

  textFont(square);

  textAlign(CENTER, CENTER);
  textSize(width/2);
  fill(0, 0, 0, 50);

  if (p1score >= 10) {
    textSize(width/3);
  }

  text(p1score, textX, height/2.5);
  textAlign(CENTER, CENTER);
  textSize(width/2);

  if (p2score >= 10) {
    textSize(width/3);
  }

  text(p2score, width - textX, height/2.5);

  textSize(width/2);
  textAlign(CENTER, CENTER);
  text(":", width / 2, height/3);
}
