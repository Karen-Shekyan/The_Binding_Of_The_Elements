import java.util.*;

class DummyEnemy implements Enemy {
  private int health;
  private float radius = 20;
  private float attack;
  //    NOTE THIS IS THE POSITION IN THE ROOM, NOT ON THE SCREEN    //
  private float xPos;
  private float yPos;
  private int stunTimer = 0;
  private ArrayList<Hurtbox> body = new ArrayList<Hurtbox>();
  private Hitbox touchZone;
  public Room room;

  public DummyEnemy(Room a) {
    attack=1;
    xPos = 300;
    yPos = 300;
    health = 50;
    //for when it deletes itself later
    room = a;
    body.add(new Hurtbox(xPos, yPos, radius));
    touchZone = new Hitbox(xPos, yPos, radius, 0, 0, room);
  }
  
  Hitbox getTouchZone() {
    return touchZone;
  }
  
  ArrayList<Hurtbox> getHurtboxes(){
    return body;
  }
  
  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      die();
    }
  }
  
  void attack() {
  }
  
  void move() {
  }
  
  void die() {
    //enemy removes itself from the enemies list of the room it's in
    room.enemies.remove(this);
  }
  
  void display() {
    fill(255, 150, 10);
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
    
    fill(0);
    textSize(10);
    text(""+health,xPos-camC, yPos-camR);
  }
  
  void knockback(float x, float y) {// NOT HOW THIS WORKS. FIX LATER //
    xPos+=x;
    yPos+=y;
    //i might need to subtract and not add
  }

  void moveHurt() {
  }
  
  void moveHit() {
  }
  
  void setStun(int stun) {
    stunTimer = stun;
  }
  
  int getStun() {
    return stunTimer;
  }
  
  void decrementStun() {
    stunTimer--;
  }
  
  void dropLoot() {
    //nothing yet
  }
  
  float getX() {
    return xPos;
  }

  float getY() {
    return yPos;
  }
}
