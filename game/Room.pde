import java.util.*;

public class Room {

  public final float[][] floor;//[0,1) = terrain, -1 = walls, -2 = doors, -3 = hidden doors
  public final int roomType;//-1 = starting //1 = normal, 2 = treasure, 3 = shop, 4 = boss, 5 = secret
  public final int ROWS;
  public final int COLS;
  public LinkedList<Bullet> enemyBullets = new LinkedList<Bullet>();
  public LinkedList<Bullet> playerBullets = new LinkedList<Bullet>();
  public LinkedList<Enemy> enemies = new LinkedList<Enemy>();
  public LinkedList<Item> items = new LinkedList<Item>();
  public LinkedList<ActiveBomb> activeBombs = new LinkedList<ActiveBomb>();
  public int secretWhere = 0; //1 = up, 2 = down, 3 = left, 4 = right

  public Room (int rT) {
    roomType = rT;
    ROWS = 1200;
    COLS = 1500;
    floor = new float[ROWS][COLS];

    noiseSeed((int)(Math.random()*100));

    for (int i = 0; i < ROWS; i++) {
      for (int j = 0; j < COLS; j++) {
        //info each element contains
        //use two waves for better effect
        noiseDetail(1);
        floor[i][j] = noise(j/200.0, i/200.0)*2;

        if (i <= wt || j <= wt || j >= COLS-wt || i >= ROWS-wt) {//wall
          floor[i][j] = -1;
        }
      }
    }


    //enemy generation. EXPAND THIS SECTION
    if (roomType == 1) {                        //normal
      //   FOR TESTING   //
      //enemies.add(new DummyEnemy(this));
      //enemies.add(new TouchyEnemy(this));
      //enemies.add(new ShootyEnemy(this));
      //enemies.add(new StabbyEnemy(this));
      //enemies.add(new SwingyEnemy(this));
      //
      
      int numEnemies = (int)(Math.random()*3 + 4);
      for (int i = 0; i < numEnemies; i++) {
        double prob = Math.random();
        if (prob > 0.75) {
          enemies.add(new TouchyEnemy(this));
        } else if (prob > 0.5) {
          enemies.add(new StabbyEnemy(this));
        } else if (prob > 0.25) {
          enemies.add(new SwingyEnemy(this));
        } else {
          enemies.add(new ShootyEnemy(this));
        }
      }

    } else if (roomType == 2) {                 //treasure
      float healLeft = (float)Math.random();
      float healRight = (float)Math.random();

      if (healLeft > .5) {
        items.add(new Heart(COLS/2-100, ROWS/2, this));
      }
      if (healRight > .5) {
        items.add(new Heart(COLS/2+100, ROWS/2, this));
      }
      items.add(new Trinket((COLS/2), (ROWS/2), this));
    } else if (roomType == 3) {                 //shop
      float item1 = (float)Math.random();
      float item2 = (float)Math.random();

      if (item1 > .5) {
        items.add(new Heart(COLS/2-100, ROWS/2, this, 5));
      } else {
        items.add(new Bomb(COLS/2-100, ROWS/2, this, 5));
      }
      if (item2 > .67) {
        items.add(new Heart(COLS/2, ROWS/2, this, 5));
      } else if (item2 > 0.33) {
        items.add(new Bomb(COLS/2, ROWS/2, this, 5));
      } else {
        items.add(new Trinket(COLS/2, ROWS/2, this, 20));
      }
      items.add(new Trinket(COLS/2+100, ROWS/2, this, 20));
    } else if (roomType == 4) {                 //boss
      enemies.add(new BossyEnemy(this));
    } else if (roomType == 5) {                 //secret
      float typeOfSecret = (float)Math.random();
      if (typeOfSecret > 0.55) {
        float healLeft = (float)Math.random();
        float healRight = (float)Math.random();

        if (healLeft > .5) {
          items.add(new Heart(COLS/2-100, ROWS/2, this));
        }
        if (healRight > .5) {
          items.add(new Heart(COLS/2+100, ROWS/2, this));
        }
        items.add(new Trinket((COLS/2), (ROWS/2), this));
      } else if (typeOfSecret > 0.10) {
        float item1 = (float)Math.random();
        float item2 = (float)Math.random();

        if (item1 > .5) {
          items.add(new Heart(COLS/2-100, ROWS/2, this, 5));
        } else {
          items.add(new Bomb(COLS/2-100, ROWS/2, this, 5));
        }
        if (item2 > .67) {
          items.add(new Heart(COLS/2, ROWS/2, this, 5));
        } else if (item2 > 0.33) {
          items.add(new Bomb(COLS/2, ROWS/2, this, 5));
        } else {
          items.add(new Trinket(COLS/2, ROWS/2, this, 20));
        }
        items.add(new Trinket(COLS/2+100, ROWS/2, this, 20));
      } else {
        int numEnemies = (int)(Math.random()*3 + 4);
        for (int i = 0; i < numEnemies; i++) {
          double prob = Math.random();
          if (prob > 0.75) {
            enemies.add(new TouchyEnemy(this));
          } else if (prob > 0.5) {
            enemies.add(new StabbyEnemy(this));
          } else if (prob > 0.25) {
            enemies.add(new SwingyEnemy(this));
          } else {
            enemies.add(new ShootyEnemy(this));
          }
        }
      }
    }
  }

  //for debugging
  public String toString() {
    return "" + roomType;
  }
  void killAll() {
    enemies = new LinkedList<Enemy>();
  }
  void clearBullets() {
    enemyBullets = new LinkedList<Bullet>();
    playerBullets = new LinkedList<Bullet>();
  }
}
