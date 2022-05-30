import java.util.*;

public class Player implements Character {

  private int health;
  private int maxHealth;
  private int tempHealth = 0;
  public int attack;
  private float x;
  private float y;
  private int stunTimer = 0;
  private int invinTimer = 0;
  public float damageMultiplier = 1;
  public ArrayList<Hurtbox> body = new ArrayList<Hurtbox>();
  public int weaponMode;// 0 = water, 1 = earth, 2 = fire, 3 = air
  private int radius = 20; //          remove later         //
  private int attackCD = 0;

  public Player () {
    health = 6;
    maxHealth = 6;
    //tempHealth = 5;
    attack = 3;//subject to change
    x = 500+camC;
    y = 400+camR;
    //consider making the body smaller than the player appears to be. games often do this
    body.add(new Hurtbox(x, y, radius));//   change later with radius    //
    weaponMode = (int)(Math.random()*4); //    change later    //
  }

  ArrayList<Hurtbox> getHurtboxes() {
    return body;
  }

  void calculateMultiplier() {//based on mode and terrain
    if (weaponMode == 0) {
      if (pixels[width*(int)(y-camR) + (int)(x-camC)] == WATER) {
        damageMultiplier = 1.5;
      } else if (pixels[width*(int)(y-camR) + (int)(x-camC)] == FIRE) {
        damageMultiplier = 0.67;
      } else {
        damageMultiplier = 1;
      }
    }
    if (weaponMode == 1) {
      if (pixels[width*(int)(y-camR) + (int)(x-camC)] == EARTH) {
        damageMultiplier = 1.5;
      } else if (pixels[width*(int)(y-camR) + (int)(x-camC)] == AIR) {
        damageMultiplier = 0.67;
      } else {
        damageMultiplier = 1;
      }
    }
    if (weaponMode == 2) {
      if (pixels[width*(int)(y-camR) + (int)(x-camC)] == FIRE) {
        damageMultiplier = 1.5;
      } else if (pixels[width*(int)(y-camR) + (int)(x-camC)] == WATER) {
        damageMultiplier = 0.67;
      } else {
        damageMultiplier = 1;
      }
    }
    if (weaponMode == 3) {
      if (pixels[width*(int)(y-camR) + (int)(x-camC)] == AIR) {
        damageMultiplier = 1.5;
      } else if (pixels[width*(int)(y-camR) + (int)(x-camC)] == EARTH) {
        damageMultiplier = 0.67;
      } else {
        damageMultiplier = 1;
      }
    }
  }

  void takeDamage(int damage) {
      if (invinTimer == 0) {
      if (tempHealth > 0) {
        tempHealth -= damage;
      } else {
        health -= damage;
      }
      if (tempHealth < 0) {
        health += tempHealth;
        tempHealth = 0;
      }
      if (health <= 0) {
        die();
      }
      setStun(25);                                                          /////////////////////set stun here/////////////////////
      setInvin(45);
      bigMap=false;
    }
  }


  void attack() {
    if (attackCD == 0 && getStun() == 0) {
      float bulletX = (mouseX - x + camC) * 7.0/dist(x-camC, y-camR, mouseX, mouseY);
      float bulletY = (mouseY - y + camR) * 7.0/dist(x-camC, y-camR, mouseX, mouseY);
      r.playerBullets.add(new Bullet(x, y, 10, bulletX, bulletY, r, color(255, 255, 255, 170), true, (int)(attack*damageMultiplier)));
      attackCD = 20;
    }
  }


  void move() {
    //move player
    if (getStun() == 0) {
      if (R) {
        if (vx != maxV) {
          vx = Math.min(maxV, vx+a);
        }
        if (camC == r.COLS-width || x < width/2) {
          x = Math.min(x + vx, r.COLS-radius-wt);
        } else {
          camC = Math.min(r.COLS-width, camC+vx);
          x = Math.min(x + vx, r.COLS-radius-wt);
        }
      }

      if (L) {
        if (vx != -maxV) {
          vx = Math.max(-maxV, vx-a);
        }
        if (camC == 0 || x-camC > width/2) {
          x = Math.max(x + vx, radius+wt);
        } else {
          camC = Math.max(0, camC+vx);
          x = Math.max(x + vx, radius+wt);
        }
      }

      if (U) {
        if (vy != -maxV) {
          vy = Math.max(-maxV, vy-a);
        }
        if (camR == 0 || y-camR > height/2) {
          y = Math.max(y + vy, radius+wt);
        } else {
          camR = Math.max(0, camR+vy);
          y = Math.max(y + vy, radius+wt);
        }
      }

      if (D) {
        if (vy != maxV) {
          vy = Math.min(maxV, vy+a);
        }
        if (camR == r.ROWS-height || y < height/2) {
          y = Math.min(y + vy, r.ROWS-radius-wt);
        } else {
          camR = Math.min(r.ROWS-height, camR+vy);
          y = Math.min(y + vy, r.ROWS-radius-wt);
        }
      }
    }

    if (vx < 0) {
      vx = Math.min(0, vx+f);

      if (camC == 0 || x-camC > width/2) {
        x = Math.max(x + vx, radius+wt);
      } else {
        camC = Math.max(0, camC+vx);
        x = Math.max(x + vx, radius+wt);
      }
    }

    if (vx > 0) {
      vx = Math.max(0, vx-f);

      if (camC == r.COLS-width || x-camC < width/2) {
        x = Math.min(x + vx, r.COLS-radius-wt);
      } else {
        camC = Math.min(r.COLS-width, camC+vx);
        x = Math.min(x + vx, r.COLS-radius-wt);
      }
    }

    if (vy < 0) {
      vy = Math.min(0, vy+f);

      if (camR == 0 || y-camR > height/2) {
        y = Math.max(y + vy, radius+wt);
      } else {
        camR = Math.max(0, camR+vy);
        y = Math.max(y + vy, radius+wt);
      }
    }

    if (vy > 0) {
      vy = Math.max(0, vy-f);

      if (camR == r.ROWS-height || y-camR < height/2) {
        y = Math.min(y + vy, r.ROWS-radius-wt);
      } else {
        camR = Math.min(r.ROWS-height, camR+vy);
        y = Math.min(y + vy, r.ROWS-radius-wt);
      }
    }
    calculateMultiplier();
    moveHurt();
  }


  void die() {
    dead = true;
  }


  void display() {
    strokeWeight(1);
    stroke(0);
    
    fill(255);
    textSize(20);
    text(weaponMode + " " + damageMultiplier, 40, 780); //   remove later    //

    fill(255, 0, 0);
    ellipse(x-camC, y-camR, 2*radius, 2*radius);

    //    display hitbox. DEBUG PURPOSES ONLY    //
    //fill(0,0,255);
    //for (int i = 0; i < body.size(); i++) {
    //  ellipse(body.get(i).getX(),body.get(i).getY(),body.get(i).getR()*2,body.get(i).getR()*2);
    //}

    //display health
    for (int i = 0; i < maxHealth; i++) {
      if (i < health) {
        if (i%2 == 1) {
          shape(redHeart, 10+i*30, 10, 44, 44);
        } else if (i+1==health) {
          shape(halfHeart, 10+(i+1)*30, 10, 44, 44);
        }
      } else if (i%2==0) {
        shape(emptyHeart, 10+(i+1)*30, 10, 44, 44);
      }
    }
    for (int i = 0; i < tempHealth; i++) {
      fill(135);
      if (i%2 == 1) {
        shape(spiritHeart, 30*maxHealth+10+i*30, 10, 44, 44);
      } else if (i+1==tempHealth) {
        shape(halfSpiritHeart, 30*maxHealth+10+(i+1)*30, 10, 44, 44);
      }
    }
  }


  void knockback(float x, float y) {
    vx += x;
    vy += y;
  }


  void moveHurt() {
    for (int i = 0; i < body.size(); i++) {
      body.get(i).setX(x);
      body.get(i).setY(y);
    }
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
    stunTimer = Math.max(stunTimer-1, 0);
  }

  void decrementAttackCD() {
    attackCD = Math.max(attackCD-1, 0);
  }

  void setInvin(int invin) {
    invinTimer = invin;
  }

  int getInvin() {
    return invinTimer;
  }

  void decrementInvin() {
    invinTimer = Math.max(invinTimer-1, 0);
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  int getR() {
    return radius;
  }

  void setX(float n) {
    x = n;
  }

  void setY(float n) {
    y = n;
  }
}
