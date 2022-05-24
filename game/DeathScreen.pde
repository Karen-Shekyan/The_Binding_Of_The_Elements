void showDeathScreen() {
  background(10);
  textSize(70);
  fill(200, 10, 50);
  text("YOU DIED", width/2-190, height/3); //maybe add a message for how you died?

  textSize(35);
  if (mouseX > width/2 - 75 && mouseX < width/2+20 && mouseY < height/2 + 55 && mouseY > height/2 + 20) {
    fill(190);
  } else {
    fill(255);
  }
  text("Retry", width/2-70, height/2+50);

  if (mouseX > width/2 - 75 && mouseX < width/2+20 && mouseY < 2*height/3 + 5 && mouseY > 2*height/3 - 40) {
    fill(190);
  } else {
    fill(255);
  }
  text("Menu", width/2-70, 2*height/3);

  if (!dead) {
    size(1000, 800);
    loadPixels();
    r = new Room(1);//  change later  //
    Aang = new Player();
    LEVEL = new Dungeon(1);
  }
}
