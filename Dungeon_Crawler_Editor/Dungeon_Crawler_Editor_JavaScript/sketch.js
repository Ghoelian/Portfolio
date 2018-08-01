var cubeSize;
var level = 
[
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
  [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], 
];

function setup() {
  createCanvas(750, 750);

  cubeSize = width / 15;
}

function draw() {
  background(150);

  for (var i = 0; i < cubeSize; i++) {
    if (i > 0) {
      line(i * cubeSize, 0, i * cubeSize, height);
      line(0, i * cubeSize, width, i * cubeSize);
    }
  }

  for (var i = 0; i < 15; i++) {
    for (var j = 0; j < 15; j++) {
      if (level[i][j] == 1) {
        fill(0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 2) {
        fill(0, 255, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 5) {
        fill(255, 255, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 3) {
        fill(255, 0, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }

      if (level[i][j] == 4) {
        fill(140, 70, 0);
        rect(j * cubeSize, i * cubeSize, cubeSize, cubeSize);
      }
    }
  }
}

/*
 65 A: Wall
 70 F: Player
 68 D: Enemy
 83 S: Chest
 71 G: Exit
 32  : Erase
 */

function keyPressed() {
  var x = Math.floor(mouseX / cubeSize);
  var y = Math.floor(mouseY / cubeSize);

  if (keyCode == 65) {
    level[y][x] = 1;
  }

  if (keyCode == 70) {
    level[y][x] = 2;
  }

  if (keyCode == 68) {
    level[y][x] = 3;
  }

  if (keyCode == 83) {
    level[y][x] = 4;
  }

  if (keyCode == 71) {
    level[y][x] = 5;
  }

  if (keyCode == 32) {
    level[y][x] = 0;
  }

  if (keyCode == 13) {
    document.getElementById("output").innerHTML += "[<br>";
    
    for(var i = 0; i < level.length; i++) {
      document.getElementById("output").innerHTML += "&nbsp;&nbsp;[";
      for(var j = 0; j < level[i].length; j++) {
        if(j < level[1].length-1) {
          document.getElementById("output").innerHTML += level[i][j] + ",&nbsp;";
        } else {
          document.getElementById("output").innerHTML += level[i][j];
        }
      }
      document.getElementById("output").innerHTML += "],<br>";
    }
    document.getElementById("output").innerHTML += "]";
  }
}