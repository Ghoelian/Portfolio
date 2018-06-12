let windowX = 600;
let windowY = 600;

let cubeSize = 20;

let playerLength = 5;
let snakeLength = 3;

let playerX = 14;
let playerY = 15;

let tailPosX = [];
let tailPosY = [];

let rows = windowY / cubeSize;
let cols = windowX / cubeSize;

let gameStart = false;

let dir = 3;

let time = 0;

let fruitXfloat = (Math.random() * cols - 1) + 1;
let fruitYfloat = (Math.random() * rows - 1 + 1);

let fruitX = Math.floor(fruitXfloat);
let fruitY = Math.floor(fruitYfloat);

let score = 0;

function setup() {
  createCanvas(windowX, windowY);

  for (let i = 0; i < 3; i++) {
    tailPosX.push(14);
  }

  for (let i = 14; i >= 12; i--) {
    tailPosY.push(i);
  }
}

function draw() {
  background(52);
  time += 1;



  showPlayer();
  movePlayer();
  drawFruit();
  addFruit();

  fill(255);
  textSize(30);
  textAlign(LEFT);
  text(score, 0, 25);

  if (gameStart == false) {
    startScreen();
  }

  if (gameOver()) {
    fill(255, 0, 0);
    textSize(32);
    textAlign(CENTER);
    text("Game Over", width / 2, height / 2);
    textSize(19);
    text("Press 'R' to restart", width / 2, height / 2 + 20);
    noLoop();
  }
}

function keyPressed() {
  if (keyCode == 87 && dir != 3 && gameStart == true) {
    dir = 1;
  } else if (keyCode == 65 && dir != 2 && gameStart == true) {
    dir = 4;
  } else if (keyCode == 83 && dir != 1 && gameStart == true) {
    dir = 3;
  } else if (keyCode == 68 && dir != 4 && gameStart == true) {
    dir = 2;
  } else if (keyCode == 82 && gameOver()) {
    loop();
    restart();
  }

  if (keyCode == 87 && dir != 3 && gameStart == false) {
    gameStart = true;
    loop();
    dir = 1;
  } else if (keyCode == 65 && dir != 2 && gameStart == false) {
    gameStart = true;
    loop();
    dir = 4;
  } else if (keyCode == 83 && dir != 1 && gameStart == false) {
    gameStart = true;
    loop();
    dir = 3;
  } else if (keyCode == 68 && dir != 4 && gameStart == false) {
    gameStart = true;
    loop();
    dir = 2;
  }
}

function movePlayer() {
  if (time % 6 == 0) {
    for (let i = snakeLength - 1; i >= 0; i--) {
      if (i == 0) {
        tailPosX[i] = playerX;
        tailPosY[i] = playerY;
      } else {
        tailPosX[i] = tailPosX[i - 1];
        tailPosY[i] = tailPosY[i - 1];
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

function showPlayer() {
  for (let i = 0; i < snakeLength; i++) {
    stroke(0);
    fill(0, 255, 0);
    rect(tailPosX[i] * cubeSize, tailPosY[i] * cubeSize, cubeSize, cubeSize);
  }

  fill(0, 255, 0);
  rect(playerX * cubeSize, playerY * cubeSize, cubeSize, cubeSize);
}

function addFruit() {
  if (fruitGot() || time == 1) {
    fruitXfloat = (Math.random() * cols - 1) + 1;
    fruitYfloat = (Math.random() * rows - 1) + 1;

    fruitX = Math.floor(fruitXfloat);
    fruitY = Math.floor(fruitYfloat);

    if (fruitX == playerX && fruitY == playerY) {
      addFruit();
    }

    for (let i = 0; i < snakeLength; i++) {
      if (fruitX == tailPosX[i] && fruitY == tailPosY[i]) {
        addFruit();
      }
    }
  }
}

function drawFruit() {
  fill(255, 0, 0);
  ellipse((fruitX * cubeSize) + cubeSize / 2, (fruitY * cubeSize) + cubeSize / 2, cubeSize, cubeSize);
}

function fruitGot() {
  if (playerX == fruitX && playerY == fruitY) {
    tailPosX.push(tailPosX[snakeLength - 1] - cubeSize);
    tailPosY.push(tailPosY[snakeLength - 1] - cubeSize);

    snakeLength += 1;
    score += 1;
    return true;
  }
  return false;
}

function gameOver() {
  for (let i = 0; i < snakeLength; i++) {
    if (tailPosX[i] == playerX && tailPosY[i] == playerY) {
      return true;
    }
  }

  if (playerX * cubeSize >= width || playerX * cubeSize < 0 || playerY * cubeSize >= height || playerY * cubeSize < 0) {
    return true;
  } else {
    return false;
  }
}

function restart() {
  loop();

  score = 0;
  playerX = 14;
  playerY = 15;
  fruitXfloat = (Math.random() * cols - 1) + 1;
  fruitYfloat = (Math.random() * rows - 1) + 1;

  fruitX = Math.floor(fruitXfloat);
  fruitY = Math.floor(fruitYfloat);
  dir = 3;
  snakeLength = 3;

  for (let i = 0; i < tailPosX.length; i++) {
    tailPosX.pop(i);
    tailPosY.pop(i);
  }

  for (let i = 0; i < 3; i++) {
    tailPosX.push(14);
  }

  for (let i = 14; i >= 12; i--) {
    tailPosY.push(i);
  }
}

function startScreen() {
  fill(255, 255, 255);

  textAlign(CENTER);
  textSize(32);

  text("Use WASD to move", width/2, height / 2);

  textSize(19);
  text("Press W, A, S or D to start", width / 2, height / 2 + 20);

  noLoop();
}
