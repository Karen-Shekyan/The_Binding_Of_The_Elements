//its a separate class so i can color it

class Bullet extends Hitbox {
  color col;
  float vx;
  float vy;
  boolean playerBullet;
  //i'd rather differeentiate between whether a bullet is a player's or not than have two different bullet classes
  //i know it's bad form but i'm lazy

  public Bullet(float x, float y, float r, float vx, float vy, Room room, color c, boolean b) {
    //velocity as a parameter might be removed from the superclass later, so the other comments in this method are preparation for that
    super(x, y, r, vx, vy, room);
    col=c;
    playerBullet = b;
    //this.vx=vx;
    //this.vy=vy;
  }
  public Bullet(float x, float y, float vx, float vy, Room room, color c, boolean b) {
    this(x, y, 10, vx, vy, room, c, b);
    //this constructor is honestly unnecessary
  }

  void display() {
    //fill(230, 240, 255, 220);
    fill(240, 240, 100, 200);
    noStroke();
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
    stroke(1);
  }

  void move() {
    //they're 0 for some reason
    xPos += vx;
    yPos += vy;

    if (xPos <= wt || yPos <= wt || xPos >= r.COLS-wt || yPos >= r.ROWS-wt) {
      if (playerBullet) {
        r.playerBullets.remove(this);
      } else {
        r.enemyBullets.remove(this);
      }
    }
  }

  /*
  //it yells at me if i don't make it specific to a certain kind of enemy. i can fix this later by making enemy an abstract class
   boolean isTouching(TouchyEnemy other) {
   float d = Integer.MAX_VALUE;
   for (int i = 0; i < other.hurtboxes.length; i++) {
   d = distance(other.hurtboxes[i]);
   if (d <= getR() + other.hurtboxes[i].getR()) {
   return true;
   }
   }
   return false;
   }
   
   //having essentially identical methods is disgusting, i need to make enemy an abstract class
   boolean isTouching(DummyEnemy other) {
   float d = Integer.MAX_VALUE;
   for (int i = 0; i < other.hurtboxes.length; i++) {
   d = distance(other.hurtboxes[i]);
   if (d <= getR() + other.hurtboxes[i].getR()) {
   return true;
   }
   }
   return false;
   }
   */

  boolean isTouching(Hurtbox[] other) {
    float d = Integer.MAX_VALUE;
    for (int i = 0; i < other.length; i++) {
      d = distance(other[i]);
      if (d <= getR() + other[i].getR()) {
        return true;
      }
    }
    return false;
  }

  //instead of separate enemyBullet and playerBullet classes, i made a nifty boolean! we probably won't even use it since the bullets are in separate lists based on type (well they will be, we still don't have enemy bullets)
  boolean isPlayerBullet() {
    return playerBullet;
  }
}
