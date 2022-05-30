class ShootyEnemy implements Enemy {
  private int health;
  private float radius = 20;
  public int attack;
  private float xPos;
  private float yPos;
  private int stunTimer = 0;
  private ArrayList<Hurtbox> body = new ArrayList<Hurtbox>();
  private Hitbox touchZone;
  public Room room;
  private int attackCD = 30;
  //states
  private boolean chasing = false;
  private boolean running = false;
  private boolean strafing = true; //starts here

  public ShootyEnemy (Room a) {
    room = a;
    attack = 1;
    xPos = (float)(Math.random()*(a.COLS-2*wt) + wt);
    yPos = (float)(Math.random()*(a.ROWS-2*wt) + wt);
    health = 20;

    body.add(new Hurtbox(xPos, yPos, radius));
    touchZone = new Hitbox(xPos, yPos, radius, 0, 0, room);
  }

  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      die();
    }
    setStun(10);
  }

  void decrementAttackCD() {
    attackCD = Math.max(attackCD-1, 0);
  }

  void attack() {
    if (attackCD == 0) {
      float bulletX = (Aang.getX() - xPos) * 7.0/dist(Aang.getX(), Aang.getY(), xPos, yPos);
      float bulletY = (Aang.getY() - yPos) * 7.0/dist(Aang.getX(), Aang.getY(), xPos, yPos);
      r.enemyBullets.add(new Bullet(xPos, yPos, 10, bulletX, bulletY, r, color(255, 255, 255, 170), false, attack));
      attackCD = 90;//    longer than player's CD    //
    }
  }

  void move() {//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (stunTimer == 0) {
      float strafeDist = 200;
      float distToPlayer = dist(getX(), getY(), Aang.getX(), Aang.getY());
      float error = 5;
      if (distToPlayer > strafeDist + error) {//get closer
        xPos += 3.0 * (Aang.getX()-getX())/distToPlayer;
        yPos += 3.0 * (Aang.getY()-getY())/distToPlayer;
      } else if (distToPlayer < strafeDist - error) {//move away//  THIS IS VERY JITTERY. use states to better control.
        xPos += -7.0 * (Aang.getX()-getX())/distToPlayer;
        yPos += -7.0 * (Aang.getY()-getY())/distToPlayer;
      } else {//strafe 
        xPos += -3.0 * (Aang.getY()-getY())/distToPlayer;
        yPos += 3.0 * (Aang.getX()-getX())/distToPlayer;
      }
      moveHurt();
      moveHit();
    }
  }//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void die() {
    dropLoot();

    //enemy removes itself from the enemies list of the room it's in
    room.enemies.remove(this);
  }

  void display() {
    stroke(0);
    strokeWeight(1);

    fill(0, 150, 150);
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);

    fill(0);
    textSize(10);
    text(""+health, xPos-camC, yPos-camR);
    decrementAttackCD();
  }

  void knockback(float x, float y) {
  }

  void moveHurt() {
    for (int i = 0; i < body.size(); i++) {
      body.get(i).setX(getX());
      body.get(i).setY(getY());
    }
  }

  void moveHit() {
    touchZone.setX(getX());
    touchZone.setY(getY());
  }

  void setStun(int stun) {
    stunTimer = stun;
  }

  int getStun() {
    return stunTimer;
  }

  void decrementStun() {
    stunTimer = Math.max(0, stunTimer-1);
  }

  float getX() {
    return xPos;
  }

  float getY() {
    return yPos;
  }

  ArrayList<Hurtbox> getHurtboxes() {
    return body;
  }

  void dropLoot() {
  }

  Hitbox getTouchZone() {
    return touchZone;
  }
}
