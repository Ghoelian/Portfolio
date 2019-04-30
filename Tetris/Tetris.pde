int cubeSize = 40;


void setup() {
  size(480, 880);
}

void draw() {
  background(0);
  drawGrid();
}

void drawGrid() {
  for (int i = 0; i < width/cubeSize; i++) {
    if (i>0) {
      line(i*cubeSize, 0, i*cubeSize, height);
    }
  }

  for (int i = 0; i < height/cubeSize; i ++) {
    if (i > 0) {
      line(0, i*cubeSize, width, i*cubeSize);
    }
  }

  for (int i = 0; i < width/cubeSize; i++) {
    for (int j = 0; j < height/cubeSize; j++) {
      if (i == 0 || i == width/cubeSize-1) {
        fill(52);
        rect(i*cubeSize, j*cubeSize, cubeSize, cubeSize);
      }
      if (j == 0 || j == height/cubeSize-1) {
        fill(52);
        rect(i*cubeSize, j*cubeSize, cubeSize, cubeSize);
      }
    }
  }
}