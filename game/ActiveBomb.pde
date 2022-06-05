public class ActiveBomb {
  float x;
  float y;
  Room room;
  int timer = 0;  //flashes for 30 frames, then blows up over 15 frames
  Hitbox touchZone;

  public ActiveBomb (float x, float y, Room r) {
    this.x = x;
    this.y = y;
    room = r;
  }

  void display () {
    if (timer == 45) {
      room.activeBombs.remove(this);
    } else if (timer < 30) {//ticking down
      if (timer/5 % 2 == 1) {
        fill(0);
        ellipse(x-camC,y-camR, 25,25);
      } else {
        fill(181, 36, 4);
        ellipse(x-camC,y-camR, 25,25);
      }
    } else {//explode
      float radius;
      if (timer - 30 < 5) {
        radius = 15 * (timer - 30);
      } else {
        radius = 7.5 * (10 - (timer - 35));
      }
      touchZone = new Hitbox(x, y, radius, 0, 0, room);
      fill(150 - 7.5 * (timer-30), 75, 75);
      ellipse(x-camC, y-camR, 2*radius, 2*radius);
      
      for (int i = 0; i < room.enemies.size(); i++) {
        Enemy guy = room.enemies.get(i);
        if (touchZone.isTouching(guy)) {
          guy.takeDamage(15);                         // enemy damaged here //
        }
      }
      
      if (touchZone.isTouching(Aang)) {
        Aang.takeDamage(2);
        float dx = (Aang.getX() - x) / (dist(Aang.getX(), Aang.getY(), x, y)+1); //the +1 is here to prevent divide-by-zero nonsense
        float dy = (Aang.getY() - y) / (dist(Aang.getX(), Aang.getY(), x, y)+1);
        Aang.knockback(dx * 5.0, dy * 5.0);
      }
    }
    timer++;
  }
}
