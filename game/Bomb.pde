public class Bomb implements Item {
  float x;
  float y;
  Room room;
  Hitbox areaOfEffect;
  
  public Bomb (float x, float y, Room r) {
    this.x = x;
    this.y = y;
    room = r;
    
    areaOfEffect = new Hitbox(x,y,10,0,0, room);
  }
  
  void effect(Player p) {
    println("BOMB");
    p.addBomb();
    
    room.items.remove(this);
  }
  
  void display() {
    strokeWeight(1);
    stroke(0);
    fill(0);
    ellipse(x-camC,y-camR, 20, 20);
  }
  
  boolean isTouching(Player p) {
    return areaOfEffect.isTouching(p);
  }
}
