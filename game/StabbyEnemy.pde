class StabbyEnemy implements Enemy {
  private int health;
  private float radius = 20;
  public int attack;
  private float xPos;
  private float yPos;
  private int stunTimer = 20;
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
  //movement
  private int moveTimer = 0; //this is how long until Touchy picks a new direction to move in.
  private float moveDX;
  private float moveDY;
  private boolean strafingCW;

  public StabbyEnemy (Room a) {
    room = a;
    attack = 1;
    xPos = (float)(Math.random()*(a.COLS-4*wt) + 2*wt);
    yPos = (float)(Math.random()*(a.ROWS-4*wt) + 2*wt);
    health = 15;

    body.add(new Hurtbox(xPos, yPos, radius));
    touchZone = new Hitbox(xPos, yPos, radius, 0, 0, room);
    
    if (Math.random() > 0.5) {
      strafingCW = true;
    } else {
      strafingCW = false;
    }
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
    moveTimer = Math.max(moveTimer-1, 0);
    if (stunTimer == 0) {
      float distToPlayer = dist(getX(), getY(), Aang.getX(), Aang.getY());

      if (chasing) {
        if (moveTimer == 0) {//choose direction
          float d = dist(Aang.getX(), Aang.getY(), getX(), getY());
          float cosAngle = (Aang.getX() - xPos) / d;
          float sinAngle = (Aang.getY() - yPos) / d;

          moveDX = cosAngle*cos((float)Math.random()*PI/6 - PI/12) - sinAngle*sin((float)Math.random()*PI/6 - PI/12);
          moveDY = sinAngle*cos((float)Math.random()*PI/6 - PI/12) + cosAngle*sin((float)Math.random()*PI/6 - PI/12);

          moveTimer = 50 + (int)(Math.random()*10);
        } else {//move in direction
          xPos += 3.0 * moveDX;
          yPos += 3.0 * moveDY;

          xPos = Math.min(room.COLS-wt-radius, Math.max(wt+radius, xPos));
          yPos = Math.min(room.ROWS-wt-radius, Math.max(wt+radius, yPos));

          moveHurt();
          moveHit();
        }

        if (dist(getX(), getY(), Aang.getX(), Aang.getY()) <= 80) {
          chasing = false;
          strafing = true;
        }
      } else if (strafing) {
        if (strafingCW) {
          xPos += 2.0 * (Aang.getY()-getY())/distToPlayer;
          yPos += -2.0 * (Aang.getX()-getX())/distToPlayer;
        } else {
          xPos += -2.0 * (Aang.getY()-getY())/distToPlayer;
          yPos += 2.0 * (Aang.getX()-getX())/distToPlayer;
        }
        distToPlayer = dist(getX(), getY(), Aang.getX(), Aang.getY());
        if (distToPlayer >= 100) {
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
    if (attacking) {////////////////////////////////////////////////////////////////////////////////////////////////
      //println(attackDX + " " + attackDY); //debug print statement
      attackFrame += 1;

      //display weapon
      stroke(171, 184, 186);
      strokeWeight(5);
      line(getX()-camC, getY()-camR, getX()-camC + attackDX * 20*(5-abs(attackFrame - 5)), getY()-camR + attackDY * 20*(5-abs(attackFrame - 5)));

      //hit player
      if (Aang.getX() - getX() < attackDX * 20*(5-abs(attackFrame - 5)) + 20 && Aang.getY() - getY() < attackDY * 20*(5-abs(attackFrame - 5)) + 20) {
        Aang.takeDamage(1);
        Aang.knockback(attackDX*3.0, attackDY*3.0);
      }
    }              ////////////////////////////////////////////////////////////////////////////////////////////////

    stroke(0);
    strokeWeight(1);

    fill(150, 150, 150);
    //ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
    shape(stabbySprite, xPos-camC-radius, yPos-camR-radius, 2*radius, 2*radius);

    //fill(0);
    //textSize(10);
    //text(""+health, xPos-camC, yPos-camR);
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
    double rng = Math.random();
    if (rng<0.15) {
      room.items.add(new Heart(xPos,yPos,room));
    }
    
    rng = Math.random();
    if (rng < 0.08) {
      room.items.add(new Bomb(xPos,yPos,room));
    }
    
    rng = Math.random();
    if (rng < 0.85) {
      Aang.increaseWealth();
    }
  }

  Hitbox getTouchZone() {
    return touchZone;
  }
}
