public class Player implements Character {

  private int health;
  private int maxHealth;
  private int tempHealth = 0;
  private int attack;
  private float x;
  private float y;
  private int stunTimer = 0;
  private float damageMultiplier = 1;
  private int radius = 20; //          remove later         //

  public Player () {
    health = 6;
    maxHealth = 6;
    attack = 3;//subject to change
    x = 500;
    y = 400;
  }

  void takeDamage(int damage) {
    health -= damage;
  }
  
  
  void attack() {
  }
  
  
  void move() {
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
  }
  
  
  void die() {
  }
  
  
  void display() {
    fill(255, 0, 0);
    ellipse(x, y, 2*radius, 2*radius);
  }
  
  
  void knockback(float x, float y) {
  }
  
  
  void moveHurt() {
  }
  
  
  void moveHit() {
  }
  
  
  void setStun() {
  }
  
  
  void getStun() {
  }
  
  
  void decrementStun() {
  }
}
