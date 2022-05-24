void menu() {
  //i hate this color, but it's one of the only colors on which you can easily see all of the element colored text
  background(200, 190, 120);
  textSize(80);
  if (frameCount%70==0) {
    menuTextMode++;
    menuTextMode%=4;
  }
  switch(menuTextMode) {
  case 0:
    fill(EARTH);
    break;
  case 1:
    fill(FIRE);
    break;
  case 2:
    fill(WATER);
    break;
  case 3:
    fill(AIR);
    break;
  }
  text("The Binding Of\n The Elements", 200, height/5);

  textSize(40);
  if (mouseX > width/2-65 && mouseX < width/2+20 && mouseY > 3*height/5-40 & mouseY < 3*height/5+5) {
    fill(150);
  } else{
    fill(0);
  }
  text("Play", width/2-60, 3*height/5);
  
  if (mouseX > width/2-65 && mouseX < width/2+25 && mouseY > 3*height/4-40 & mouseY < 3*height/4+5) {
    fill(150);
  } else{
    fill(0);
  }
  text("Quit",width/2-60,3*height/4);
  
  
}
