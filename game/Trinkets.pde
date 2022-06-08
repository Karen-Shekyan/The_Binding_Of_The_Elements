public class Trinket implements Item{
  float xPos;
  float yPos;
  float radius;
  Room room;
  Hitbox areaOfEffect;
  int type;
  
  public Trinket(float x, float y, Room r, int type) {
    xPos = x;
    yPos = y;
    room = r;
    areaOfEffect = new Hitbox(x,y,0,0,15,r);
    this.type = type;
    switch (type) {
      case 1:
        
      break;
    }
  }
  //maxHealth up, maxHelath up and one heal, maxHealth up and full heal, speed up, damage up, mak health up, flat damage bonus(?), tear cooldown down, tear speed up, tear size increase, double invin, [more to come]
  
  void display() {
    fill(230,230,255);
    ellipse(xPos-camC,yPos-camR,30,30);
    textSize(10);
    fill(10);
    text(""+type,xPos-camC,yPos-camR);
  }
  //need to make it continue to display even after it's picked up (in the pause menu)
  
  void effect(Player p) {
    Aang.trinkets.add(this);
    room.items.remove(this);
    //when/if i make fragile trinkets, i need to have the code to remove them from the player list (reminder to me) - not the best place for the note tbh
  }
  
  boolean isTouching(Player p) {
    return areaOfEffect.isTouching(p);
  }
}
