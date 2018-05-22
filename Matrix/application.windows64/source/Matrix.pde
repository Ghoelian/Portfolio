Number[] numbers = new Number[500];

void setup() {
  size(640, 360);

  for (int i = 0; i < numbers.length; i++) {
    numbers[i] = new Number();
  }
}

void draw() {
  background(0);
  
  for (int i = 0; i < numbers.length; i++) {
    numbers[i].show();
    numbers[i].fall();
  }
}
