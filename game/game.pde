int wt = 100;
float camR = 200;//corresponds to y
float camC = 250;//corresponds to x
boolean dead = false;
//control movement for Player
boolean R = false;
boolean L = false;
boolean U = false;
boolean D = false;
boolean MOUSE = false;
//speeds of the Player
float vx = 0.0;
float vy = 0.0;
float maxV = 2.5;
// forces on Player
float a = 0.3;//acceleration
float f = 0.2;//frictional force
Room r;
Player Aang;
color EARTH = color(87, 62, 29);
color FIRE = color(212, 8, 8);
color WATER = color(54, 143, 199);
color AIR = color(212, 236, 250);
Dungeon LEVEL;

final int firingLimit=30;
int lastFired=0;
boolean gunJustFired;

void setup() {
  size(1000, 800);
  loadPixels();
  r = new Room(1);//  change later  //
  Aang = new Player();
  LEVEL = new Dungeon(1);
}

void draw() {
  if (dead) {
    dead = false;
    size(1000, 800);
    loadPixels();
    r = new Room(1);//  change later  //
    Aang = new Player();
  }

  for (int i = (int)camR; i < height+(int)camR; i++) {
    for (int j = (int)camC; j < width+(int)camC; j++) {
      if (r.floor[i][j] == -1) {//make 6 sections, not 4
        pixels[width*(i-(int)camR) + (j-(int)camC)] = color(0);
      } else if (r.floor[i][j] > 0.70) {//earth
        pixels[width*(i-(int)camR) + (j-(int)camC)] = EARTH;
      } else if (r.floor[i][j] > 0.5) {//fire
        pixels[width*(i-(int)camR) + (j-(int)camC)] = FIRE;
      } else if (r.floor[i][j] > 0.30) {//water
        pixels[width*(i-(int)camR) + (j-(int)camC)] = WATER;
      } else {//air
        pixels[width*(i-(int)camR) + (j-(int)camC)] = AIR;
      }
    }
  }

  updatePixels();

  for (int i = 0; i < r.enemies.size(); i++) {
    Enemy guy = r.enemies.get(i);
    guy.move();
    guy.display();
    if (guy.getTouchZone().isTouching(Aang)) {
      Aang.takeDamage(1);
    }
  }


  for (int j = 0; j < r.playerBullets.size(); j++) {
    Bullet bullet = r.playerBullets.get(j);
    //not working rn, bullet gets no velocity
    bullet.move();

    for (int i = 0; i < r.enemies.size(); i++) {
      Enemy guy = r.enemies.get(i);

      if (bullet.isTouching(guy)) {
        guy.takeDamage(Aang.attack);
        r.playerBullets.remove(bullet);//    put this into hitbox once room is fixed    //
      }
    }

    bullet.display();
  }

  Aang.move();
  Aang.display();
  if (MOUSE) {
    Aang.attack();
  }
  Aang.decrementAttackCD();
}

//updating booleans for each arrow key
void keyPressed() {
  if (key == 'd') {
    R = true;
  }
  if (key == 'a') {
    L = true;
  }
  if (key == 'w') {
    U = true;
  }
  if (key == 's') {
    D = true;
  }
}

void keyReleased() {
  if (key == 'd') {
    R = false;
  }
  if (key == 'a') {
    L = false;
  }
  if (key == 'w') {
    U = false;
  }
  if (key == 's') {
    D = false;
  }
}

void mousePressed() {
  if (lastFired==firingLimit-1 || !gunJustFired) {
    MOUSE = true;
    gunJustFired=true;;
    lastFired++;
    lastFired%=firingLimit;
  } else {
    MOUSE= false;
    lastFired++;
    gunJustFired=false;
  }
}

void mouseReleased() {
  MOUSE = false;
  gunJustFired=false;
}
