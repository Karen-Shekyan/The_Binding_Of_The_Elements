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
      if (neighbor / 10 != 8 && neighbor % 10 != 0 && roomsLeft != 0 && get(neighbor) == null && countNeighbors(neighbor) == 1 && Math.random() > 0.5) {
        queue.add(neighbor);
        level[neighbor%10-1][neighbor/10] = new Room(1);
        roomsLeft--;
      } else {
        giveUps++;
      }

      neighbor = room - 10;
      if (neighbor / 10 != 8 && neighbor % 10 != 0 && roomsLeft != 0 && get(neighbor) == null && countNeighbors(neighbor) == 1 && Math.random() > 0.5) {
        queue.add(neighbor);
        level[neighbor%10-1][neighbor/10] = new Room(1);
        roomsLeft--;
      } else {
        giveUps++;
      }

      neighbor = room + 1;
      if (neighbor / 10 != 8 && neighbor % 10 != 0 && roomsLeft != 0 && get(neighbor) == null && countNeighbors(neighbor) == 1 && Math.random() > 0.5) {
        queue.add(neighbor);
        level[neighbor%10-1][neighbor/10] = new Room(1);
        roomsLeft--;
      } else {
        giveUps++;
      }

      neighbor = room - 1;
      if (neighbor / 10 != 8 && neighbor % 10 != 0 && roomsLeft != 0 && get(neighbor) == null && countNeighbors(neighbor) == 1 && Math.random() > 0.5) {
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
    if (n < 0 || n%10 == 0 || n/10 == -1 || n/10 >= 8) {//bounds check
      return null;
    }
    return level[n%10-1][n/10];
  }

  private int countNeighbors(int n) {
    if (n < 0) {
      return 2;
    }
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

  void displayMiniMap() {
    noStroke();
    //background of minimap
    fill(30, 30, 30, 150);
    rect(width-250, 5, width-5, 10+20*level.length);

    for (int i = 0; i < level.length; i++) {
      for (int j = 0; j < level[i].length; j++) {
        if (get(10*j+i+1)==null) {
          noFill();
        } else if (i==(currentRoom%10-1) && j==(currentRoom/10)) {
          fill(220);
        } else if (explored[i][j] != null) {
          fill(150);
        } else {// unexplored rooms should be invisible.
          fill(100);
        }
        rect(width - 245 + 30*(j), 10 + 20*(i), 27, 17);
        drawPins(i,j);
      }
    }
  }

  void drawPins(int i, int j) {
    if (get(10*j+i+1)!=null) {
      if (get(10*j+i+1).roomType==2) {
        drawCrown(width - 245 + 30*(j)+9, 10 + 20*(i)+2);
      } else if (get(10*j+i+1).roomType==3) {
        drawCoin(width - 245 + 30*(j)+13, 10 + 20*(i)+9);
      } else if (get(10*j+i+1).roomType==4) {
        drawSkull(width - 245 + 30*(j)+13, 10 + 20*(i)+7);
      }
    }
  }
  
  void drawSkull(int x, int y){
    fill(150);
    ellipse(x,y,12,12);
    rect(x-4,y,8,9);
    fill(10);
    stroke(0.5);
    line(x-4,y+7,x+4,y+5);
    ellipse(x-3,y,4,3);
    ellipse(x+3,y,4,3);
    noStroke();
  }
  
  void drawCoin(int x, int y){
    fill(170,140,130);
    ellipse(x,y,13,13);
    textSize(12);
    fill(10);
    text("¢",x-4,y+4.6);
  }

  void drawCrown(int x, int y) {
    fill(255, 240, 50);
    triangle(x, y+13, x+10, y+13, x, y);
    triangle(x, y+13, x+10, y+13, x+5, y);
    triangle(x, y+13, x+10, y+13, x+10, y);
  }
}
