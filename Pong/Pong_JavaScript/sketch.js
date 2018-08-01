var p1y;
var p2y;
var speed = 5;
var ySpeed = -5;
var xSpeed = 4;
var ballX;
var ballY;
var p1score = 0;
var p2score = 0;

var p1up = false;
var p1down = false;
var p2up = false;
var p2down = false;
var ballMove = false;

function preload() {
  square = loadFont('fonts/square.ttf');
  soundFormats("wav");

  wall = loadSound("sound/wall.wav");
  points = loadSound("sound/point.wav");
  paddle = loadSound("sound/paddle.wav");
}

function setup() {
  createCanvas(700, 400);

  p1y = height/2;      // Starts p1 and p2 out in the middle of the screen
  p2y = height/2;

  ballX = width/2;     // Starts the ball out in the middle of the screen
  ballY = height/2;

  wall.setVolume(1);
  points.setVolume(1);
  paddle.setVolume(1);
}

function draw() {
  background(200);

  score();
  p1();
  p2();
  ball();
  edges();
}

function p1() {                  // Draws p1's paddle
  rectMode(CENTER);
  fill(255);
  rect(16, p1y, 16, height / 7, 5);

  if (p1up == true && p1y - (height / 7) / 2 > 2) {        // Moves the player up if p1up is true
    p1y -= speed;
  } else if (p1down == true && p1y + (height / 7) / 2 < height - 2) {  // Moves the player down if p1down is true
    p1y += speed;
  }
}

function p2() {
  rectMode(CENTER);    // Draws p2's paddle
  fill(255);
  rect(width - 16, p2y, 16, height / 7, 5);

  if (p2up == true && p2y - (height / 7) / 2 > 2) {  // Moves the paddle up if p2up is true
    p2y -= speed;
  } else if (p2down == true && p2y + (height / 7) / 2 < height - 2) {    // Moves the paddle down if p2down is true
    p2y += speed;
  }
}

function ball() {
  fill(255);        // Draws the ball
  ellipse(ballX, ballY, 16, 16);

  if (ballMove == true) {    // Moves the ball if it's allowed to
    ballX += xSpeed;
    ballY += ySpeed;
  } else {                   // Shows the "Perss enter to start" text if someone has just scored a povar or if the game was just started
    textAlign(CENTER, CENTER);
    fill(0, 0, 0, 255);
    textSize(20);
    text("Press space to start", width/2, height/4);
  }
}

function edges() {
  if (ballY - 8 <= 0 || ballY + 8 >= height) {    // Checks if the ball is on the top/down edges of the screen
    ySpeed = ySpeed * -1;
    wall.play();
  }

  if (ballX - 8 >= width - 40 && ballY >= p2y - 30 && ballY <= p2y + 30 && ballX - 8 <= width - 30) {    // Checks if the ball hit the right paddle
    xSpeed = xSpeed * -1;
    paddle.play();
  }

  if (ballX + 8 <= 40 && ballY >= p1y - 30 && ballY <= p1y + 30 && ballX >= 30) {   // Checks if the ball hit the left paddle
    xSpeed = xSpeed * -1;
    paddle.play();
  }

  if (ballX <= 0) {    // Increments the score and resets ball if the ball is off the right of the screen
    p2score++;
    points.play();
    resetBall();
  }

  if (ballX >= width) { // Increments the score and resets ball if the ball is off the left of the screen
    p2score++;
    points.play();
    resetBall();
  }
}

function resetBall() {      // Resets the ball back to the middle, and makes it not move
  ballX = width / 2;
  ballY = height / 2;

  ballMove = false;
}

function keyPressed() {
  if (keyCode == 87) {        // Sets p1up/p1down to true if the W or S keys are held down
    p1up = true;
  } else if (keyCode == 83) {
    p1down = true;
  }

  if (keyCode == 38) {      // Sets p2up/p2down to true if the up or down keys are held down
    p2up = true;
  } else if (keyCode == 40) {
    p2down = true;
  }

  if (keyCode == 32 && ballMove == false) {    // Makes the ball move if you press enter
    ballMove = true;
  }
}

function keyReleased() {
  if (keyCode == 87) {        // Sets p1up/p1down to false if the W or S keys are let go of
    p1up = false;
  } else if (keyCode == 83) {
    p1down = false;
  }

  if (keyCode == 38) {        // Sets p2up/p2down to false if the up or down keys are let go of
    p2up = false;
  } else if (keyCode == 40) {
    p2down = false;
  }
}

function score() {        // Draws the scores on the screen
  var textX = height / 2;

  textFont(square);

  textAlign(CENTER, CENTER);
  textSize(width/2);
  fill(0, 0, 0, 50);

  if (p1score >= 10) {    // Makes the text size smaller if the score >= 10
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