Number n;

void setup() {
  size(640, 360);

  n = new Number();
  n.prepare();
}

void draw() {
  frameRate(15);
  background(0);
  n.show();
}
