import java.util.*;

public class Player implements Character {

  private int health;
  private int maxHealth;
  private int tempHealth = 0;
  private int attack;
  private float x;
  private float y;
  private int stunTimer = 0;
  private float damageMultiplier = 1;
  public ArrayList<Hurtbox> body = new ArrayList<Hurtbox>();
  public int weaponMode;// 0 = water, 1 = earth, 2 = fire, 3 = air
  private int radius = 20; //          remove later         //

  public Player () {
    health = 6;
    maxHealth = 6;
    attack = 3;//subject to change
    x = 500;
    y = 400;
    //consider making the body smaller than the player appears to be. games often do this
    body.add(new Hurtbox(x,y,radius));//   change later with radius    //
    weaponMode = (int)(Math.random()*4); //    change later    //
  }

  void calculateMultiplier() {
    if (weaponMode == 0) {
      if (pixels[width*(int)(y) + (int)(x)] == WATER) {
        damageMultiplier = 1.5;
      } else if (pixels[width*(int)(y) + (int)(x)] == FIRE) {
        damageMultiplier = 0.67;
      } else {
        damageMultiplier = 1;
      }
    }
    if (weaponMode == 1) {
      if (pixels[width*(int)(y) + (int)(x)] == EARTH) {
        damageMultiplier = 1.5;
      } else if (pixels[width*(int)(y) + (int)(x)] == AIR) {
        damageMultiplier = 0.67;
      } else {
        damageMultiplier = 1;
      }
    }
    if (weaponMode == 2) {
      if (pixels[width*(int)(y) + (int)(x)] == FIRE) {
        damageMultiplier = 1.5;
      } else if (pixels[width*(int)(y) + (int)(x)] == WATER) {
        damageMultiplier = 0.67;
      } else {
        damageMultiplier = 1;
      }
    }
    if (weaponMode == 3) {
      if (pixels[width*(int)(y) + (int)(x)] == AIR) {
        damageMultiplier = 1.5;
      } else if (pixels[width*(int)(y) + (int)(x)] == EARTH) {
        damageMultiplier = 0.67;
      } else {
        damageMultiplier = 1;
      }
    }
  }

  void takeDamage(int damage) {
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
  }


  void attack() {
  }


  void move() {
          //move player
    if (R) {
      if (vx != maxV) {
        vx = Math.min(maxV, vx+a);
      }
      if (camC == r.COLS-width || x < width/2) {
        x = Math.min(x + vx, width-radius-wt);
      } else {
        camC = Math.min(r.COLS-width, camC+vx);
      }
    }

    if (L) {
      if (vx != -maxV) {
        vx = Math.max(-maxV, vx-a);
      }
      if (camC == 0 || x > width/2) {
        x = Math.max(x + vx, radius+wt);
      } else {
        camC = Math.max(0, camC+vx);
      }
    }

    if (U) {
      if (vy != -maxV) {
        vy = Math.max(-maxV, vy-a);
      }
      if (camR == 0 || y > height/2) {
        y = Math.max(y + vy, radius+wt);
      } else {
        camR = Math.max(0, camR+vy);
      }
    }

    if (D) {
      if (vy != maxV) {
        vy = Math.min(maxV, vy+a);
      }
      if (camR == r.ROWS-height || y < height/2) {
        y = Math.min(y + vy, height-radius-wt);
      } else {
        camR = Math.min(r.ROWS-height, camR+vy);
      }
    }


    if (vx < 0) {
      vx = Math.min(0, vx+f);

      if (camC == 0 || x > width/2) {
        x = Math.max(x + vx, radius+wt);
      } else {
        camC = Math.max(0, camC+vx);
      }
    }

    if (vx > 0) {
      vx = Math.max(0, vx-f);

      if (camC == r.COLS-width || x < width/2) {
        x = Math.min(x + vx, width-radius-wt);
      } else {
        camC = Math.min(r.COLS-width, camC+vx);
      }
    }

    if (vy < 0) {
      vy = Math.min(0, vy+f);

      if (camR == 0 || y > height/2) {
        y = Math.max(y + vy, radius+wt);
      } else {
        camR = Math.max(0, camR+vy);
      }
    }

    if (vy > 0) {
      vy = Math.max(0, vy-f);

      if (camR == r.ROWS-height || y < height/2) {
        y = Math.min(y + vy, height-radius-wt);
      } else {
        camR = Math.min(r.ROWS-height, camR+vy);
      }
    }

    calculateMultiplier();
    
    //move Hurtbox(s)
    for (int i = 0; i < body.size(); i++) {
      body.get(i).setX(x);
      body.get(i).setY(y);
    }
  }


  void die() {
    dead = true;
  }


  void display() {
    fill(255);
    textSize(20);
    text(weaponMode + " " + damageMultiplier, 40, 780); //   remove later    //

    fill(255, 0, 0);
    ellipse(x, y, 2*radius, 2*radius);
    
    //    display hitbox. DEBUG PURPOSES ONLY    //
    //fill(0,0,255);
    //for (int i = 0; i < body.size(); i++) {
    //  ellipse(body.get(i).getX(),body.get(i).getY(),body.get(i).getR()*2,body.get(i).getR()*2);
    //}
    
    //display health
    for (int i = 0; i < maxHealth; i++) {
      if (i < health) {
        fill(186, 39, 22);
      } else {
        noFill();
      }

      if (i%2 == 0) {//left
        arc(40+i*30, 40, 30, 30, HALF_PI, 3*HALF_PI);
      } else {//right
        arc(40+(i-1)*30, 40, 30, 30, 3*HALF_PI, 5*HALF_PI);
      }
    }
    for (int i = 0; i < tempHealth; i++) {
      fill(135);
      if (i%2 == 0) {//left
        arc((maxHealth)*40+i*30-20, 40, 30, 30, HALF_PI, 3*HALF_PI);
      } else {//right
        arc((maxHealth)*40+(i-1)*30-20, 40, 30, 30, 3*HALF_PI, 5*HALF_PI);
      }
    }
  }


  void knockback(float x, float y) {
  }


  void moveHurt() {
  }


  void moveHit() {
  }


  void setStun(int stun) {
  }


  int getStun() {
    return stunTimer;
  }


  void decrementStun() {
  }
}
