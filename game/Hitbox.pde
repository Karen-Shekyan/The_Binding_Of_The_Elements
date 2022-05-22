//THESE ARE CONTACT BOXES AND BULLETS. NOT SWORDS
//SEPARATE ENEMY AND PLAYER HITBOXES.
class Hitbox {//consider making these smaller than projectiles look
  float radius;
  float xPos;
  float yPos;
  float vx;
  float vy;
  Room r;

  public Hitbox(float x, float y, float r, float vx, float vy, Room where) {
    xPos=x;
    yPos=y;
    radius = r;
    this.vx = vx;
    this.vy = vy;
    this.r = where;
  }
  
  void move() {
    xPos += vx;
    yPos += vy;
    if (xPos <= wt || yPos <= wt || xPos >= r.COLS-wt || yPos >= r.ROWS-wt) {
      r.bullets.remove(this);
    }
  }
  
  void display() {
    
  }

  float getX() {
    return xPos;
  }

  float getY() {
    return yPos;
  }

  float getR() {
    return radius;
  }

  void setX(float x) {
    xPos = x;
  }

  void setY(float y) {
    yPos = y;
  }
  
  //Enemy hitboxes and player hitboxes MUST be separated.
  boolean isTouching(Player other) {
    float d = Integer.MAX_VALUE;
    for (int i = 0; i < other.body.size(); i++) {
      d = distance(other.body.get(i));
      if (d <= getR() + other.body.get(i).getR()) {
        return true;
      }
    }
    return false;
  }
  
  //we didn't really need a separate method for this
  float distance(Hurtbox other) {
    float d = dist(getX(), getY(), other.getX(), other.getY());
    return d;
  }
}
