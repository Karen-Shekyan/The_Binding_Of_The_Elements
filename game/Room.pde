import java.util.*;

public class Room {

  public final float[][] floor;
  public final int roomType;//-1 = starting //1 = normal, 2 = treasure, 3 = shop, 4 = boss, 5 = secret
  public final int ROWS;
  public final int COLS;
  public LinkedList<Bullet> enemyBullets = new LinkedList<Bullet>();
  public LinkedList<Bullet> playerBullets = new LinkedList<Bullet>();
  public LinkedList<Enemy> enemies = new LinkedList<Enemy>();
  public LinkedList<Item> items = new LinkedList<Item>();
  //need to initialize

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
        //door
        //if ((i <= wt && j <= COLS/2 + 75 && j >= COLS/2 - 75) || (i >= ROWS-wt && j <= COLS/2 + 75 && j >= COLS/2 - 75) || (j <= wt && i <= ROWS/2 + 75 && i >= ROWS/2 - 75) || (j >= COLS-wt && i <= ROWS/2 + 75 && i >= ROWS/2 - 75)) {
        //  floor[i][j] = -2;
        //}
      }
    }
    
    
    //enemy generation. EXPAND THIS SECTION
    if (roomType == 1) {                        //normal
    //   FOR TESTING   //
      //enemies.add(new DummyEnemy(this));
      //enemies.add(new TouchyEnemy(this));
      //enemies.add(new ShootyEnemy(this));
      //enemies.add(new StabbyEnemy(this));
      enemies.add(new SwingyEnemy(this));
    //
    
      //int numEnemies = (int)(Math.random()*3 + 4);
      //for (int i = 0; i < numEnemies; i++) {
      //  double prob = Math.random();
      //  if (prob > 0.7) {
      //    enemies.add(new TouchyEnemy(this));
      //  } else if (prob > 0.4) {
      //    enemies.add(new StabbyEnemy(this));
      //  } else {
      //    enemies.add(new ShootyEnemy(this));
      //  }
      //}
    } else if (roomType == 2) {                 //treasure
      
    } else if (roomType == 3) {                 //shop
      
    } else if (roomType == 4) {                 //boss
      enemies.add(new MiniEnemy(this));
    } else if (roomType == 5) {                 //secret
      
    }
  }

  //for debugging
  public String toString() {
    return "" + roomType;
  }
}
