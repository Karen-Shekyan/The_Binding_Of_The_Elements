void showEndScreen() {
  background(190, 225, 240);
  textSize(40);
  fill(255);
  if (endScreenTime > 50) {
    text("And so,", width/2-70, height/4+20);
  }
  if (endScreenTime > 140) {
    text("Aang defeated the fire nation,", 220, height/4+70);
  }
  if (endScreenTime > 250) {
    text("and the other 3 nations lived in peace", 130, height/2-40);
    text("once more.", width/2-110, height/2+10);
  }
  if (endScreenTime > 370) {
    textSize(35);
    if (mouseX > width/2 - 100 && mouseX < width/2+90 && mouseY < 2*height/3 + 65 && mouseY > 2*height/3 + 35) {
      fill(200);
    } else {
      fill(255);
    }
    text("New Game", width/2-95, 2*height/3+60);

    if (mouseX > width/2 - 125 && mouseX < width/2+110 && mouseY < 4*height/5 + 35 && mouseY > 4*height/5 + 5) {
      fill(200);
    } else {
      fill(255);
    }
    text("Back to Menu", width/2-120, 4*height/5+30);
  }

  //timer
  endScreenTime++;
}
