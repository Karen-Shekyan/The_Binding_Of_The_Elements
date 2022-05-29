class Bullet extends Hitbox {
  color col;
  boolean playerBullet;
  int damage;

  public Bullet(float x, float y, float r, float vx, float vy, Room room, color c, boolean b, int damage) {
    //velocity as a parameter might be removed from the superclass later, so the other comments in this method are preparation for that
    //response to above: NO IT WILL NOT. It is more general this way
    super(x, y, r, vx, vy, room);
    col=c;
    playerBullet = b;
    this.damage = damage;
  }
  public Bullet(float x, float y, float vx, float vy, Room room, color c, boolean b, int damage) {
    this(x, y, 10, vx, vy, room, c, b, damage);
    //this may be unnecessary
  }
  
  int getDam() {
    return damage;
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
      if (playerBullet) { //<>// //<>//
        r.playerBullets.remove(this);
      } else { //<>// //<>//
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
}
