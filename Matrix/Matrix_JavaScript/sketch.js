function setup() {
  createCanvas(700, 700);
}

function draw() {
  background(0);
  
  print(createNumbers(500));
}

function getRandom(min, max) {
  return Math.random() * (max - min) + min;
}

function createNumbers(n) {
  var numbers = new Array(n);

  for(var i = 0; i < n; i++) {
    numbers[i] = new Number();
  }

  return numbers;
}

function Number() {
  var colsize = 15;
  var y = getRandom(-height*2, -height);
  var yspeed = getRandom(3, 6);
  var amount = getRandom(4, 30);
  var rows = width/colsize;
  var x = getRandom(rows);
  
    y = y + yspeed;

    if (y > height) {
      y = getRandom(-700, -300);
    }
  

    var green = 0;
    
    for (var i = 0; i < amount; i++) {
      var number = getRandom(0, 2);
      
      fill(0, green, 0);
      text(number, x * colsize, y + i * colsize);
      green += getRandom(10, 50);
    
  }
}