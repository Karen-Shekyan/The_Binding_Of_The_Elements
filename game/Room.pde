import java.util.*;

public class Room {

  public final float[][] floor;
  public final int roomType;//1 = normal, 2 = treasure, 3 = shop, 4 = boss, 5 = secret
  public final int ROWS;
  public final int COLS;
  public LinkedList<Bullet> enemyBullets = new LinkedList<Bullet>();
  public LinkedList<Bullet> playerBullets = new LinkedList<Bullet>();
  public LinkedList<Enemy> enemies = new LinkedList<Enemy>();
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
        noiseDetail(1);
        floor[i][j] = noise(j/200.0, i/200.0)*2;

        if (i <= wt || j <= wt || j >= COLS-wt || i >= ROWS-wt) {//wall
          floor[i][j] = -1;
        }
      }
    }

    //enemy generation. EXPAND THIS SECTION
    enemies.add(new DummyEnemy(this));
    enemies.add(new TouchyEnemy(this));
    enemies.add(new ShootyEnemy(this));
  }

//for debugging
  public String toString() {
    return "" + roomType;
  }
}
