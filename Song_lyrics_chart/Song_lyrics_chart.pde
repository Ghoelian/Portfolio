String[] lyrics; //<>// //<>// //<>// //<>// //<>// //<>//
String[] lyricsSplit;
boolean[][] grid;
int size;
int gridSize;
int offset;
int fontSize;
float colour;
float floatSize;
PGraphics pg;

void setup() {
  size(1063, 1041);
  pg = createGraphics(7434, 7287);

  lyrics = loadStrings("lyrics.txt");
  lyricsSplit = split(lyrics[0], " ");
  size = lyricsSplit.length;
  floatSize = size;
  fontSize = pg.height / 256;
  offset = pg.height / 50;

  grid = new boolean[size][size];
  gridSize = pg.height / grid.length;

  findSize();

  pg.beginDraw();
  pg.background(0);
  drawLyrics();
  checkLyrics();
  drawPoints();
  
  pg.endDraw();
  image(pg, 0, 0, width, height);
  pg.save("frame.png");
}

void drawLyrics() {
  pg.textSize(fontSize);
  pg.textAlign(RIGHT);
  for (int i = 0; i < lyricsSplit.length; i++) {
    pg.text(lyricsSplit[i], offset, (i * gridSize) + gridSize);
  }
}

void checkLyrics() {
  for (int i = 0; i < lyricsSplit.length; i++) {
    for (int j = 0; j < lyricsSplit.length; j++) {
      if (lyricsSplit[i].equals(lyricsSplit[j])) {
        grid[i][j] = true;
      }
    }
  }
}

void drawPoints() {
  pg.noStroke();
  ellipseMode(CORNER);

  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (grid[i][j] == true) {
        pg.fill(255);
        pg.ellipse((i * gridSize) + offset + 2, j * gridSize, gridSize, gridSize);
      }
    }
  }
}

void findSize() {
  for (float i = 1; i < 10000; i++) {
    if ((i / size) % 1 == 0) {
      println((int(i) + (int(i) / 50) + 2) + " x " + int(i));
    }
  }
}

color getColor() {
  color colour = #FFFFFF;
  return colour;
}
