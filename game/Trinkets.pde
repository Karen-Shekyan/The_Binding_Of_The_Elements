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
  
  void display() {
    fill(230,230,255);
    ellipse(xPos-camC,yPos-camR,2*radius,2*radius);
    textSize(10);
    fill(10);
    text(""+type,xPos-camC,yPos-camR);
  }
  
  void effect(Player p) {
  }
  
  boolean isTouching(Player p) {
    return areaOfEffect.isTouching(p);
  }
}
