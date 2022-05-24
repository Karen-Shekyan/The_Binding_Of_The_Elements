void pauseGame(){
  fill(200);
  rect(150,100,width-300,height-200);
  fill(30);
  textSize(40);
  text("Paused",width/2-65,170);
  
  //eventually there should be a bunch of stuff here, like a list of trinkets, an elapsed playtime, and maybe the minimap if we can't overlay it on the dungeon
}
