int cols = 20;
int rows = cols;

void setup() {
  size(600, 600);

  for (int i = 1; i < width; i++) {
    line((height / cols) * i, 0, (height / cols) * i, height);
  }

  for (int i = 1; i < height; i++) {
    line(0, (width / rows) * i, width, (width / rows) * i);
  }
}

void draw() {
}
