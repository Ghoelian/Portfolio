class Lyrics {
  void drawLyrics() {
    pg.textSize(fontSize);
    pg.textAlign(RIGHT);
    for (int i = 0; i < lyricsSplit.length; i++) {
      pg.text(lyricsSplit[i], xOffset, (i * gridSize) + gridSize);
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

  void stripChars() {
    for (int i = 0; i < lyricsSplit.length; i++) {
      String newWord = "";
      for (int j = 0; j < lyricsSplit[i].length(); j++) {
        if (lyricsSplit[i].charAt(j) != ',' && lyricsSplit[i].charAt(j) != '.' && lyricsSplit[i].charAt(j) != '\'' && lyricsSplit[i].charAt(j) != '"' && lyricsSplit[i].charAt(j) != ' ' && lyricsSplit[i].charAt(j) != '`' && lyricsSplit[i].charAt(j) != '!' && lyricsSplit[i].charAt(j) != '?' && lyricsSplit[i].charAt(j) != '(' && lyricsSplit[i].charAt(j) != ')') {
          newWord += lyricsSplit[i].charAt(j);
        }
      }
      lyricsSplit[i] = newWord;
    }
  }

  String joinLyrics() {
    String result = "";

    for (int i = 0; i < lyricsArray.length; i++) {
      if (i == 0) {
        result += lyricsArray[i];
      } else {
        result += " " + lyricsArray[i];
      }
    }

    return result;
  }
}
