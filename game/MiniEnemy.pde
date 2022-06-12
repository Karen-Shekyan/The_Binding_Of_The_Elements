class MiniEnemy implements Enemy {
  private int health;
  private float radius = 50;
  public int attack;
  private float xPos;
  private float yPos;
  private int stunTimer = 20;
  private ArrayList<Hurtbox> body = new ArrayList<Hurtbox>();
  private Hitbox touchZone;
  public Room room;
  private int attackCD = 30;
  //states
  private boolean chasing = false;
  private boolean running = false;
  private boolean strafing = true; //starts here

  public MiniEnemy (Room a) {
    room = a;
    attack = 1;
    xPos = a.COLS/2;
    yPos = a.ROWS/2;
    health = 150;

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
      float distToAang = dist(Aang.getX(), Aang.getY(), xPos, yPos);
      float cosAngle = (Aang.getX() - xPos) * 1.0/distToAang;
      float sinAngle = (Aang.getY() - yPos) * 1.0/distToAang;

      float bulletX1 = 7.0 * cosAngle;
      float bulletY1 = 7.0 * sinAngle;
      r.enemyBullets.add(new Bullet(xPos, yPos, 10, bulletX1, bulletY1, r, color(255, 255, 255, 170), false, attack));

      float bulletX2 = 7.0 * (cosAngle * cos(PI/12) - sinAngle * sin(PI/12));
      float bulletY2 = 7.0 * (sinAngle * cos(PI/12) + cosAngle * sin(PI/12));
      r.enemyBullets.add(new Bullet(xPos, yPos, 10, bulletX2, bulletY2, r, color(255, 255, 255, 170), false, attack));

      float bulletX3 = 7.0 * (cosAngle * cos(-PI/12) - sinAngle * sin(-PI/12));
      float bulletY3 = 7.0 * (sinAngle * cos(-PI/12) + cosAngle * sin(-PI/12));
      r.enemyBullets.add(new Bullet(xPos, yPos, 10, bulletX3, bulletY3, r, color(255, 255, 255, 170), false, attack));

      float bulletX4 = 7.0 * (cosAngle * cos(PI/6) - sinAngle * sin(PI/6));
      float bulletY4 = 7.0 * (sinAngle * cos(PI/6) + cosAngle * sin(PI/6));
      r.enemyBullets.add(new Bullet(xPos, yPos, 10, bulletX4, bulletY4, r, color(255, 255, 255, 170), false, attack));

      float bulletX5 = 7.0 * (cosAngle * cos(-PI/6) - sinAngle * sin(-PI/6));
      float bulletY5 = 7.0 * (sinAngle * cos(-PI/6) + cosAngle * sin(-PI/6));
      r.enemyBullets.add(new Bullet(xPos, yPos, 10, bulletX5, bulletY5, r, color(255, 255, 255, 170), false, attack));

      attackCD = 60;
    }
  }

  void move() {//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    if (stunTimer == 0) {
      float distToPlayer = dist(getX(), getY(), Aang.getX(), Aang.getY());
      
      if (chasing) {
        xPos += 3.0 * (Aang.getX()-getX())/distToPlayer;
        yPos += 3.0 * (Aang.getY()-getY())/distToPlayer;
        if (dist(getX(), getY(), Aang.getX(), Aang.getY()) <= 300) {
          chasing = false;
          strafing = true;
        }
      } else if (running) {
        xPos += -3.5 * (Aang.getX()-getX())/distToPlayer;
        yPos += -3.5 * (Aang.getY()-getY())/distToPlayer;
        if (dist(getX(), getY(), Aang.getX(), Aang.getY()) >= 200) {
          running = false;
          strafing = true;
        }
      } else if (strafing) {
        xPos += -3.0 * (Aang.getY()-getY())/distToPlayer;
        yPos += 3.0 * (Aang.getX()-getX())/distToPlayer;
        distToPlayer = dist(getX(), getY(), Aang.getX(), Aang.getY());
        if (distToPlayer <= 150) {
          strafing = false;
          running = true;
        } else if (distToPlayer >= 350) {
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
  }////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  void die() {
    dropLoot();

    //enemy removes itself from the enemies list of the room it's in
    room.enemies.remove(this);
  }

  void display() {
    stroke(0);
    strokeWeight(1);

    fill(0, 150, 0);
    //ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
    shape(miniBossSprite, xPos-camC-radius, yPos-camR-radius, 2*radius, 2*radius);

    //fill(0);
    //textSize(10);
    //text(""+health, xPos-camC, yPos-camR);
    decrementAttackCD();
    
    drawHealthBar();
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
    Aang.increaseWealth((int)(Math.random()*11)+5);
  }

  Hitbox getTouchZone() {
    return touchZone;
  }
  
  void drawHealthBar() {
    fill(50);
    strokeWeight(2);
    rect(200,height-70,width-400,30);
    noStroke();
    fill(220,50,85); //color is gross, should fix later
    rect(200,height-70,(float)health/150*(width-400),30);
  }
}
