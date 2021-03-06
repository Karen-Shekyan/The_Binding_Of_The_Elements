import java.util.*;

public class Dungeon {
  public Room[][] level;
  public final Room[][] explored;

  // c = 0 always unused rooms  
  public Dungeon(int n) { //n is the level number
    level = new Room[9][8];
    generate(n);
    explored = new Room[9][8];

    /*
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
    */
  }

  public Room get(int r, int c) {
    try {
      return level[r][c];
    } 
    catch (IndexOutOfBoundsException ex) {
      //println("caught");
      return null;
    }
  }

  public void generate(int n) {
    level = new Room[9][8];
    int roomsLeft;
    if (n == 1) {
      roomsLeft = 10 + (int)(Math.random()*3);
    } else {
      roomsLeft = 15 + (int)(Math.random()*4);
    }

    ArrayList<Integer> endRooms = new ArrayList<Integer>();
    ArrayDeque<Integer> queue = new ArrayDeque<Integer>();
    queue.add(35);
    level[4][3] = new Room(-1);
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
      //println("failed");//    for debugging    //
      generate(n);
    } else {
      //place special rooms
      int boss = endRooms.get(endRooms.size()-1);
      int shop = endRooms.get(endRooms.size()-2);
      int treasure = endRooms.get(endRooms.size()-3);
      level[boss%10-1][boss/10] = new Room(4);
      bossRoom = boss;
      level[shop%10-1][shop/10] = new Room(3);
      level[treasure%10-1][treasure/10] = new Room(2);

      //place secret room   cosider trading time for space
      boolean done = false;
      int attempts = 0;
      while (!done) {
        int guess = 10*(int)(Math.random()*8)+(int)(Math.random()*8+1);

        if (attempts < 300) {
          if (get(guess) == null && !endRoomNeighbors(guess, endRooms) && countNeighbors(guess) >= 3) {
            level[guess%10-1][guess/10] = new Room(5);
            done = true;
            //println("under 300");
          }
        } else if (attempts < 600) {
          if (get(guess) == null && !endRoomNeighbors(guess, endRooms) && countNeighbors(guess) >= 2) {
            level[guess%10-1][guess/10] = new Room(5);
            done = true;
            //println("under 600");
          }
        } else {
          if (get(guess) == null && !endRoomNeighbors(guess, endRooms) && countNeighbors(guess) >= 1) {
            level[guess%10-1][guess/10] = new Room(5);
            done = true;
            //println("over 600");
          }
        }
        attempts++;
      }

      //place doors
      for (int i = 0; i < level.length; i++) {
        for (int j = 0; j < level[i].length; j++) {
          Room at = get(i, j);

          if (at != null) {
            //up
            if (get(i-1, j) != null && get(i-1, j).roomType != 5) { //door
              for (int k = 0; k <= wt; k++) {
                for (int l = at.COLS/2 - 75; l <= at.COLS/2 + 75; l++) {
                  at.floor[k][l] = -2;
                }
              }
            } else if (get(i-1, j) != null && get(i-1, j).roomType == 5) { //hidden door
              for (int k = 0; k <= wt; k++) {
                for (int l = at.COLS/2 - 75; l <= at.COLS/2 + 75; l++) {
                  at.floor[k][l] = -3;
                  at.secretWhere = 1;
                }
              }
            }

            //down
            if (get(i+1, j) != null && get(i+1, j).roomType != 5) { //door
              for (int k = at.ROWS-wt; k < at.ROWS; k++) {
                for (int l = at.COLS/2 - 75; l <= at.COLS/2 + 75; l++) { 
                  at.floor[k][l] = -2;
                }
              }
            } else if (get(i+1, j) != null && get(i+1, j).roomType == 5) { //hidden door
              for (int k = at.ROWS-wt; k < at.ROWS; k++) {
                for (int l = at.COLS/2 - 75; l <= at.COLS/2 + 75; l++) {
                  at.floor[k][l] = -3;
                  at.secretWhere = 2;
                }
              }
            }

            //left
            if (get(i, j-1) != null && get(i, j-1).roomType != 5) { //door
              for (int k = at.ROWS/2 - 75; k <= at.ROWS/2 + 75; k++) {
                for (int l = 0; l <= wt; l++) {
                  at.floor[k][l] = -2;
                }
              }
            } else if (get(i, j-1) != null && get(i, j-1).roomType == 5) { //hidden door
              for (int k = at.ROWS/2 - 75; k <= at.ROWS/2 + 75; k++) {
                for (int l = 0; l <= wt; l++) {
                  at.floor[k][l] = -3;
                  at.secretWhere = 3;
                }
              }
            }

            //right
            if (get(i, j+1) != null && get(i, j+1).roomType != 5) { //door
              for (int k = at.ROWS/2 - 75; k <= at.ROWS/2 + 75; k++) {
                for (int l = at.COLS-wt; l < at.COLS; l++) {
                  at.floor[k][l] = -2;
                }
              }
            } else if (get(i, j+1) != null && get(i, j+1).roomType == 5) { //hidden door
              for (int k = at.ROWS/2 - 75; k <= at.ROWS/2 + 75; k++) {
                for (int l = at.COLS-wt; l < at.COLS; l++) {
                  at.floor[k][l] = -3;
                  at.secretWhere = 4;
                }
              }
            }
          }
        }
      }
    }
  }

  private Room get(int n) {
    if (n < 0 || n%10 == 0 || n/10 == -1 || n/10 >= 8) {//bounds check
      return null;
    }
    return level[n%10-1][n/10];
  }

  private Room getExplored(int n) {
    if (n < 0 || n%10 == 0 || n/10 == -1 || n/10 >= 8) {//bounds check
      return null;
    }
    return explored[n%10-1][n/10];
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

  private boolean endRoomNeighbors(int roomNum, ArrayList<Integer> endRooms) {
    return endRooms.contains(roomNum - 1) || endRooms.contains(roomNum - 10) || endRooms.contains(roomNum + 1) || endRooms.contains(roomNum + 10);
  }

  void displayMiniMap() {
    noStroke();
    //background of minimap
    fill(30, 30, 30, 150);

    if (bigMap) {
      rect(width-400, 5, width-5, 10+35*level.length);

      for (int i = 0; i < level.length; i++) {
        for (int j = 0; j < level[i].length; j++) {
          noFill();
          if (get(10*j+i+1)==null) {
            noStroke();
          } else if (i==(currentRoom%10-1) && j==(currentRoom/10)) {
            noStroke();
            fill(220);
            rect(width - 395 + 40*(j), 10 + 35*(i), 37, 32);
            drawPins(i, j, bigMap);
          } else if (getExplored(10*j+i+1) != null) {
            noStroke();
            fill(150);
            rect(width - 395 + 40*(j), 10 + 35*(i), 37, 32);
            drawPins(i, j, bigMap);
          } else if (getExplored(10*j+i+1)==null  && (getExplored(10*j+i+1+10) != null || getExplored(10*j+i+1-10) != null || getExplored(10*j+i) != null || getExplored(10*j+i+2) != null)) {
            // unexplored rooms should be invisible.
            noStroke();
            fill(100);
            rect(width - 395 + 40*(j), 10 + 35*(i), 37, 32);
            drawPins(i, j, bigMap);
          }
        }
      }
    } else {
      rect(width-250, 5, width-5, 10+20*level.length);

      for (int i = 0; i < level.length; i++) {
        for (int j = 0; j < level[i].length; j++) {
          noFill();
          if (get(10*j+i+1)==null) {
            noStroke();
          } else if (i==(currentRoom%10-1) && j==(currentRoom/10)) {
            noStroke();
            fill(220);
            rect(width - 245 + 30*(j), 10 + 20*(i), 27, 17);
            drawPins(i, j, bigMap);
          } else if (getExplored(10*j+i+1) != null) {
            noStroke();
            fill(150);
            rect(width - 245 + 30*(j), 10 + 20*(i), 27, 17);
            drawPins(i, j, bigMap);
          } else if (getExplored(10*j+i+1)==null  && (getExplored(10*j+i+1+10) != null || getExplored(10*j+i+1-10) != null || getExplored(10*j+i) != null || getExplored(10*j+i+2) != null)) {
            // unexplored rooms should be invisible.
            if (get(10*j+i+1).roomType != 5) {
              noStroke();
              fill(100);
              rect(width - 245 + 30*(j), 10 + 20*(i), 27, 17);
              drawPins(i, j, bigMap);
            }
          }
        }
      }
    }
  }

  void displayMiniMapDebug() {
    noStroke();
    //background of minimap
    fill(30, 30, 30, 150);
    rect(width-250, 5, width-5, 10+20*level.length);

    for (int i = 0; i < level.length; i++) {
      for (int j = 0; j < level[i].length; j++) {
        noFill();
        if (get(10*j+i+1)==null) {
          noStroke();
        } else if (i==(currentRoom%10-1) && j==(currentRoom/10)) {
          fill(220);
        } else if (getExplored(10*j+i+1) != null) {
          fill(150);
        } else if (getExplored(10*j+i+1)==null  && (getExplored(10*j+i+1+10) != null || getExplored(10*j+i+1-10) != null || getExplored(10*j+i) != null || getExplored(10*j+i+2) != null)) {
          // unexplored rooms should be invisible.
          fill(100);
        }
        rect(width - 245 + 30*(j), 10 + 20*(i), 27, 17);
        drawPins(i, j, bigMap);
      }
    }
  }

  void drawPins(int i, int j, boolean big) {
    if (get(10*j+i+1)!=null) {
      if (big) {
        //rect(width - 395 + 40*(j), 10 + 35*(i), 37, 32);
        if (get(10*j+i+1).roomType==2) {
          //drawCrown(width - 395 + 40*(j)+12, 10 + 35*(i)+9);
          shape(crown, width - 395 + 40*(j)+9, 10 + 35*(i)+5, 20, 20);
        } else if (get(10*j+i+1).roomType==3) {
          //drawCoin(width - 395 + 40*(j)+18, 10 + 35*(i)+16);
          shape(coin, width - 395 + 40*(j)+6, 10 + 35*(i)+4, 24, 24);
        } else if (get(10*j+i+1).roomType==4) {
          //drawSkull(width - 395 + 40*(j)+18, 10 + 35*(i)+14);
          shape(skull, width - 395 + 40*(j)+8, 10 + 35*(i)+3, 24, 24);
        }
      } else { 
        if (get(10*j+i+1).roomType==2) {
          //drawCrown(width - 245 + 30*(j)+8, 10 + 20*(i)+2);
          shape(crown, width - 245 + 30*(j)+7, 10 + 20*(i));
        } else if (get(10*j+i+1).roomType==3) {
          //drawCoin(width - 245 + 30*(j)+13, 10 + 20*(i)+9);
          shape(coin, width - 245 + 30*(j)+6, 10 + 20*(i)+1, 15, 15);
        } else if (get(10*j+i+1).roomType==4) {
          //drawSkull(width - 245 + 30*(j)+13, 10 + 20*(i)+7);
          shape(skull, width - 245 + 30*(j)+6, 10 + 20*(i), 17, 17);
        }
      }
    }
    stroke(1);
  }

  //void drawSkull(int x, int y) {
  //  fill(150);
  //  noStroke();
  //  ellipse(x, y, 12, 12);
  //  rect(x-4, y, 8, 9);
  //  fill(10);
  //  stroke(0.5);
  //  line(x-4, y+7, x+4, y+7);
  //  ellipse(x-3, y, 4, 3);
  //  ellipse(x+3, y, 4, 3);
  //}

  //void drawCoin(int x, int y) {
  //  stroke(0);
  //  strokeWeight(1);
  //  fill(170, 140, 130);
  //  ellipse(x, y, 13, 13);
  //  textSize(12);
  //  fill(10);
  //  text("??", x-4, y+4.6);
  //}

  //void drawCrown(int x, int y) {
  //  stroke(0);
  //  strokeWeight(1);
  //  fill(255, 240, 50);
  //  triangle(x, y+13, x+10, y+13, x, y);
  //  triangle(x, y+13, x+10, y+13, x+10, y);
  //  triangle(x, y+13, x+10, y+13, x+5, y-3);
  //}
}
