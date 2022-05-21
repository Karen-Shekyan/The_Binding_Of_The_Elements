public class Room {
  
  public final float[][] floor;
  public final int roomType;
  public final int ROWS;
  public final int COLS;
  
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
        floor[i][j] = noise(j/200.0,i/200.0)*2;
        
        if (i <= wt || j <= wt || j >= COLS-wt || i >= ROWS-wt) {//wall
          floor[i][j] = -1;
        }
      }
    }
  }
}
