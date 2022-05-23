import java.util.*;

public class Dungeon {
  public Room[][] level;
  public final Room[][] explored;

  // c = 0 always unused rooms  
  public Dungeon(int n) { //n is the level number
    level = new Room[9][8];
    generate(n);
    explored = new Room[9][8];

    //    for debugging, remove later    //
    for (int i = 0; i < level.length; i++) {
      for (int j = 0; j < level[i].length; j++) {
        if (level[i][j] == null) {
          print("0 ");
        } else {
          print(level[i][j]+ " ");
        }
      }
      println();
    }
  }

  public Room get(int r, int c) {
    return level[r][c];
  }

  public void generate(int n) {
    level = new Room[9][8];
    int roomsLeft;
    if (n == 1) {
      roomsLeft = 7 + (int)(Math.random()*2);
    } else {
      roomsLeft = 13 + (int)(Math.random()*3);
    }

    ArrayList<Integer> endRooms = new ArrayList<Integer>();
    ArrayDeque<Integer> queue = new ArrayDeque<Integer>();
    queue.add(35);
    level[4][3] = new Room(1);
    roomsLeft--;

    while (queue.size() != 0) {
      int room = queue.poll();
      int giveUps = 0;

      int neighbor = room + 10;
      if (roomsLeft != 0 && get(neighbor) == null && countNeighbors(neighbor) == 1 && Math.random() > 0.5) {
        queue.add(neighbor);
        level[neighbor%10-1][neighbor/10] = new Room(1);
        roomsLeft--;
      } else {
        giveUps++;
      }

      neighbor = room - 10;
      if (roomsLeft != 0 && get(neighbor) == null && countNeighbors(neighbor) == 1 && Math.random() > 0.5) {
        queue.add(neighbor);
        level[neighbor%10-1][neighbor/10] = new Room(1);
        roomsLeft--;
      } else {
        giveUps++;
      }

      neighbor = room + 1;
      if (roomsLeft != 0 && get(neighbor) == null && countNeighbors(neighbor) == 1 && Math.random() > 0.5) {
        queue.add(neighbor);
        level[neighbor%10-1][neighbor/10] = new Room(1);
        roomsLeft--;
      } else {
        giveUps++;
      }

      neighbor = room - 1;
      if (roomsLeft != 0 && get(neighbor) == null && countNeighbors(neighbor) == 1 && Math.random() > 0.5) {
        queue.add(neighbor);
        level[neighbor%10-1][neighbor/10] = new Room(1);
        roomsLeft--;
      } else {
        giveUps++;
      }

      if (giveUps == 4) {
        endRooms.add(room);
      }
    }

    if (roomsLeft != 0 || endRooms.size() < 3) {
      println("failed");//    for debugging    //
      generate(n);
    } else {
      int boss = endRooms.get(endRooms.size()-1);
      int shop = endRooms.get(endRooms.size()-2);
      int treasure = endRooms.get(endRooms.size()-3);
      level[boss%10-1][boss/10] = new Room(4);
      level[shop%10-1][shop/10] = new Room(3);
      level[treasure%10-1][treasure/10] = new Room(2);
    }
  }

  private Room get(int n) {
    if (n < 0 || n%10 == 0 || n/10 == -1 || n/10 == 8) {//bounds check
      return null;
    }
    return level[n%10-1][n/10];
  }

  private int countNeighbors(int n) {
    int ans = 0;
    if (get(n-1) != null) {
      ans++;
    }
    if (get(n+1) != null) {
      ans++;
    }
    if (get(n-10) != null) {
      ans++;
    }
    if (get(n+10) != null) {
      ans++;
    }
    return ans;
  }
}
