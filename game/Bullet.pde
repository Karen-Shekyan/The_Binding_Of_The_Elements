//its a separate class so i can color it

class Bullet extends Hitbox {
  color col;
  boolean playerBullet;

  public Bullet(float x, float y, float r, float vx, float vy, Room room, color c, boolean b) {
    //velocity as a parameter might be removed from the superclass later, so the other comments in this method are preparation for that
    //response to above: NO IT WILL NOT. It is more general this way
    super(x, y, r, vx, vy, room);
    col=c;
    playerBullet = b;
  }
  public Bullet(float x, float y, float vx, float vy, Room room, color c, boolean b) {
    this(x, y, 10, vx, vy, room, c, b);
    //this may be unnecessary
  }

  void display() {
    fill(240, 240, 100, 200);
    noStroke();
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
    stroke(1);
  }

  void move() {
    xPos += vx;
    yPos += vy;

    if (xPos <= wt+getR() || yPos <= wt+getR() || xPos >= r.COLS-wt-getR() || yPos >= r.ROWS-wt-getR()) {
      if (playerBullet) {
        r.playerBullets.remove(this);
      } else {
        r.enemyBullets.remove(this);
      }
    }
  } //<>//

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
