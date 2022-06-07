public class ActiveBomb {
  float x;
  float y;
  Room room;
  int timer = 0;  //flashes for 30 frames, then blows up over 2 frames
  Hitbox touchZone;

  public ActiveBomb (float x, float y, Room r) {
    this.x = x;
    this.y = y;
    room = r;
  }

  void display () {
    if (timer == 75) {
      room.activeBombs.remove(this);
    } else if (timer < 60) {//ticking down
      if (timer/10 % 2 == 1) {
        fill(0);
        ellipse(x-camC, y-camR, 25, 25);
      } else {
        fill(181, 36, 4);
        ellipse(x-camC, y-camR, 25, 25);
      }
    } else {//explode
      float radius;
      if (timer - 60 == 0 || timer - 60 == 1) { //ouch
        radius = 100;
        fill(242, 113, 0);
        touchZone = new Hitbox(x, y, radius, 0, 0, room);
        ellipse(x-camC, y-camR, 2*radius, 2*radius);

        for (int i = 0; i < room.enemies.size(); i++) {         //hurt enemy
          Enemy guy = room.enemies.get(i);
          if (touchZone.isTouching(guy)) {
            guy.takeDamage(7);                         // enemy damaged here //
          }
        }

        if (touchZone.isTouching(Aang)) {                     //hurt player
          Aang.takeDamage(2);
          float dx = (Aang.getX() - x) / (dist(Aang.getX(), Aang.getY(), x, y)+1); //the +1 is here to prevent divide-by-zero nonsense
          float dy = (Aang.getY() - y) / (dist(Aang.getX(), Aang.getY(), x, y)+1);
          Aang.knockback(dx * 5.0, dy * 5.0);
        }
        //open hidden door
        if (dist(x, y, x, wt) < radius || dist(x, y, room.COLS/2-75, wt) < radius || dist (x, y, room.COLS/2 + 75, wt) < radius) {//up
          for (int k = 0; k <= wt; k++) {
            for (int l = room.COLS/2 - 75; l <= room.COLS/2 + 75; l++) {
              room.floor[k][l] = -2;
            }
          }
        } else if (dist(x, y, x, room.ROWS-wt) < radius || dist(x, y, room.COLS/2-75, room.ROWS-wt) < radius || dist (x, y, room.COLS/2 + 75, room.ROWS-wt) < radius) {//down
          for (int k = room.ROWS-wt; k < room.ROWS; k++) {
            for (int l = room.COLS/2 - 75; l <= room.COLS/2 + 75; l++) { 
              room.floor[k][l] = -2;
            }
          }
        } else if (dist(x, y, wt, y) < radius || dist(x, y, wt, room.ROWS/2 - 75) < radius || dist (x, y, wt, room.ROWS/2 + 75) < radius) {//left
          for (int k = room.ROWS/2 - 75; k <= room.ROWS/2 + 75; k++) {
            for (int l = 0; l <= wt; l++) {
              room.floor[k][l] = -2;
            }
          }
        } else if (dist(x, y, room.COLS-wt, y) < radius || dist(x, y, room.COLS-wt, room.ROWS/2 - 75) < radius || dist (x, y, room.COLS-wt, room.ROWS/2 + 75) < radius) {//right
          for (int k = room.ROWS/2 - 75; k <= room.ROWS/2 + 75; k++) {
            for (int l = room.COLS-wt; l < room.COLS; l++) {
              room.floor[k][l] = -2;
            }
          }
        }
      } else { //smoke
        radius = 75-5*(timer-60);
        fill(200);
        ellipse(x-camC, y-camR, 2*radius, 2*radius);
      }
    }
    timer++;
  }
}
