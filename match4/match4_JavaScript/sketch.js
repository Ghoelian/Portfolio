let a = 0;
let turn = 1;
let gameOver_ = false;

function createArray(rows) {
  let tiles = [];

  for (let i = 0; i < rows; i++) {
    tiles[i] = [];
  }

  return tiles;
}

let tiles = createArray(8);

for (let i = 0; i < 8; i++) {
  for (let j = 0; j < 8; j++) {
    tiles[i][j] = 0;
  }
}

function setup() {
  createCanvas(400, 400);
}

function draw() {
  a = width / 8;
  background(200);

  for (let i = 0; i < 8; i++) {
    for (let j = 0; j < 8; j++) {
      if (tiles[i][j] == 1) {
        fill(0, 0, 255);
        rect(i * a, j * a, a, a);
      } else if (tiles[i][j] == 2) {
        fill(0, 255, 0);
        rect(i * a, j * a, a, a);
      }
    }
  }

  for (let i = 1; i < 8; i++) {
    line(i * a, 0, i * a, height);
    line(0, i * a, width, i * a);
  }

  for (let i = 0; i < 8; i++) {
    for (let j = 0; j < 8; j++) {
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

function mousePressed() {
  let mouse = Math.floor(mouseX / a);

  for (let i = 7; i >= 0; i--) {
    if (tiles[mouse][i] == 0 && gameOver_ == false) {
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

function keyPressed() {
  if (keyCode == 82 && gameOver_ == true) {
    gameOver_ = false;
    reset();
  }
}

function gameOver(player) {
  textSize(40);
  fill(0);
  textAlign(CENTER);
  textSize(32);
  text("Player " + player + " has won!", width / 2, height / 2);
  textSize(19);
  text("Press 'R' to restart", width / 2, height / 2 + 20);
  gameOver_ = true;
}

function reset() {
  turn = 1;

  for (let i = 0; i < 8; i++) {
    for (let j = 0; j < 8; j++) {
      tiles[i][j] = 0;
    }
  }
}
