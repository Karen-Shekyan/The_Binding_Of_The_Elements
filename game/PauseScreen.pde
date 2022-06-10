void pauseGame(){
  fill(200);
  rect(200,100,width-400,3*height/5);
  //used to be rect(150,100,width-300,width-200);
  
  fill(30);
  textSize(40);
  text("Paused",width/2-65,170);
  
  textSize(30);
  text("Trinkets:",250,220); //none yet but they should be there eventually right?
  for (int i=0; i<Aang.trinkets.size() ; i++) {
    //fill(255,0,0);
    //ellipse(250+40*i,250,30,30);
    Aang.trinkets.get(i).display(i);
  }
  
  textSize(40);
  if (mouseX > width/2-110 && mouseX < width/2+105 && mouseY > 3*height/5-30 & mouseY < 3*height/5+5) {
    fill(150);
  } else{
    fill(0);
  }
  text("Quit to menu?",width/2-105,3*height/5);
  
  //eventually there should be a bunch of stuff here, like a list of trinkets, an elapsed playtime, and maybe the minimap if we can't overlay it on the dungeon
}
