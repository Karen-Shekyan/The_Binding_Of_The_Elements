//THESE ARE CONTACT BOXES AND BULLETS. NOT SWORDS
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

    //the velocities serve no function now that there's a separate bullet class. i'm leaving them as legacy in case we need them again
    //but they should be cleaned up if we still don't need them at the end of the project
    this.vx = vx;
    this.vy = vy;
    this.r = where;
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
  boolean isTouching(Character other) {
    ArrayList<Hurtbox> body = other.getHurtboxes();
    float d = Integer.MAX_VALUE;
    for (int i = 0; i < body.size(); i++) {
      d = distance(body.get(i));
      println(d);
      if (d <= getR() + body.get(i).getR()) {
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
