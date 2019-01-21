PGraphics pg;

class PgStuff {
  void doTheStuff() {
    pg = createGraphics(pgWidth, pgHeight);
    gridSize = pg.height / grid.length;
    pg.beginDraw();
    pg.background(0);
    lyrics.drawLyrics();
    lyrics.checkLyrics();
    graph.drawPoints();

    pg.endDraw();
    image(pg, 0, 0, width, height);
    pg.save("frame.png");
  }
}
