int wt = 100;
float camR = 200;//corresponds to y
float camC = 250;//corresponds to x
boolean dead = false;
boolean menu = true; //set to true by default later
boolean pause;
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
int menuTextMode = 0;

final int firingLimit=30;
int lastFired=0;
boolean gunJustFired;

void setup() {
  size(1000, 800);
  startNewGame();
  //size(1000, 800);
  //loadPixels();
  //r = new Room(1);//  change later  //
  //Aang = new Player();
  //LEVEL = new Dungeon(1);
}

void draw() {
  if (dead) {
    dead = false;
    size(1000, 800);
    loadPixels();
    r = LEVEL.get(35);//  change later  //
    Aang = new Player();
    showDeathScreen();
  } else if (menu) {
    //menu screen
    menu();
  } else if (pause) {
    //pause screen
    pauseGame();
  } else {

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


    for (int i = 0; i < r.enemies.size(); i++) {//this is contact damage. Always deals 1.
      Enemy guy = r.enemies.get(i);
      guy.move();
      guy.display();
      if (guy.getTouchZone().isTouching(Aang)) {
        Aang.takeDamage(1);
      }
      guy.attack();
    }


    for (int j = 0; j < r.playerBullets.size(); j++) {
      Bullet bullet = r.playerBullets.get(j);
      //not working rn, bullet gets no velocity
      bullet.move();

      for (int i = 0; i < r.enemies.size(); i++) {
        Enemy guy = r.enemies.get(i);

        if (bullet.isTouching(guy)) {
          guy.takeDamage(bullet.getDam());
          r.playerBullets.remove(bullet);//    put this into hitbox once room is fixed    //
        }
      }
      bullet.display();
    }

    for (int i = 0; i < r.enemyBullets.size(); i++) {
      Bullet bullet = r.enemyBullets.get(i);
      bullet.move();

      if (bullet.isTouching(Aang)) {
        Aang.takeDamage(bullet.getDam());
        r.enemyBullets.remove(bullet);//    put this into hitbox once room is fixed    //
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
  if (key == 'p') { //i'll find a diff/better key later. esc, maybe?
    //background(90);
    pause=!pause;
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
  MOUSE = true;
}

void mouseReleased() {
  MOUSE = false;
}

void mouseClicked() {
  if (menu) {
    if (mouseX > width/2-55 && mouseX < width/2+30 && mouseY > 3*height/5-40 & mouseY < 3*height/5+5) {
      menu=false;
      startNewGame();
    }
    if (mouseX > width/2-65 && mouseX < width/2+25 && mouseY > 3*height/4-40 & mouseY < 3*height/4+5) {
      exit();
    }
  }
  if (dead) {
    //the part of the screen where the menu button is
    if (mouseX > width/2 - 75 && mouseX < width/2+20 && mouseY < 2*height/3 + 5 && mouseY > 2*height/3 - 40) {
      menu=true;
      dead=false;
    }
    //the part of the screen where the retry button is
    if (mouseX > width/2 - 75 && mouseX < width/2+20 && mouseY < height/2 + 55 && mouseY > height/2 + 20) {
      dead=false;
      startNewGame();
    }
  }
  //if (pause) {}
}

void startNewGame() {
  size(1000, 800); //this is terrible form i think ...but...
  loadPixels();
  r = new Room(1);//  change later  //
  Aang = new Player();
  LEVEL = new Dungeon(1);
}
