class StabbyEnemy implements Enemy {
  private int health;
  private float radius = 20;
  public int attack;
  private float xPos;
  private float yPos;
  private int stunTimer = 0;
  private ArrayList<Hurtbox> body = new ArrayList<Hurtbox>();
  private Hitbox touchZone;
  public Room room;
  //attack variables
  private int attackCD = 30;
  private float attackRange = 100;
  private boolean attacking = false;
  private int attackFrame = 0;         //    the attack occurs over 10 frames    //
  private float attackDX;
  private float attackDY;
  //states
  private boolean chasing = false;
  private boolean strafing = true; //starts here

  public StabbyEnemy (Room a) {
    room = a;
    attack = 1;
    xPos = (float)(Math.random()*(a.COLS-4*wt) + 2*wt);
    yPos = (float)(Math.random()*(a.ROWS-4*wt) + 2*wt);
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
    if (stunTimer == 0 && !attacking && attackCD == 0 && dist(getX(), getY(), Aang.getX(), Aang.getY()) <= attackRange) {
      float distToPlayer = dist(getX(), getY(), Aang.getX(), Aang.getY());
      attacking = true;
      attackDX = (Aang.getX() - getX()) / distToPlayer;
      attackDY = (Aang.getY() - getY()) / distToPlayer;
      attackCD = 90;
    }
  }

  void move() {//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (stunTimer == 0) {
      float distToPlayer = dist(getX(), getY(), Aang.getX(), Aang.getY());

      if (chasing) {
        xPos += 3.0 * (Aang.getX()-getX())/distToPlayer;
        yPos += 3.0 * (Aang.getY()-getY())/distToPlayer;
        if (dist(getX(), getY(), Aang.getX(), Aang.getY()) <= 20) {
          chasing = false;
          strafing = true;
        }
      } else if (strafing) {
        xPos += -2.0 * (Aang.getY()-getY())/distToPlayer;
        yPos += 2.0 * (Aang.getX()-getX())/distToPlayer;
        distToPlayer = dist(getX(), getY(), Aang.getX(), Aang.getY());
        if (distToPlayer >= 50) {
          strafing = false;
          chasing = true;
        }
      }

      xPos = Math.min(room.COLS-wt-radius, Math.max(wt+radius, xPos));
      yPos = Math.min(room.ROWS-wt-radius, Math.max(wt+radius, yPos));

      moveHurt();
      moveHit();
      //println(dist(getX(), getY(), Aang.getX(), Aang.getY()));
    }
  }//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void die() {
    dropLoot();

    //enemy removes itself from the enemies list of the room it's in
    room.enemies.remove(this);
  }

  void display() {
    println(attacking);
    if (attacking) {
      attackFrame += 1;
      //display weapon
      stroke(1);
      strokeWeight(5);
      fill(171, 184, 186);
      line(getX()-camC, getY()-camR, getX()-camC + attackDX * 20*abs(attackFrame - 5), getY()-camR + attackDY * 20*abs(attackFrame - 5));
      //hit player
      if (Aang.getX() - getX() < attackDX * 20*abs(attackFrame - 5) && Aang.getY() - getY() < attackDY * 20*abs(attackFrame - 5)) {
        Aang.takeDamage(1);
        Aang.knockback(attackDX*3.0, attackDY*3.0);
      }
    }

    stroke(0);
    strokeWeight(1);

    fill(0, 150, 150);
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);

    fill(0);
    textSize(10);
    text(""+health, xPos-camC, yPos-camR);
    decrementAttackCD();

    if (attackFrame == 10) {
      attackFrame = 0;
      attacking = false;
    }
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
