int wt = 100;
float camR = 200;//corresponds to y
float camC = 250;//corresponds to x
boolean dead = false;
boolean menu = true;
boolean pause;
boolean gameSaved;

//controls for Player
boolean R = false;
boolean L = false;
boolean U = false;
boolean D = false;
boolean MOUSE = false;

//speeds of the Player
float vx = 0.0;
float vy = 0.0;
float maxV = 2.5;

//forces on Player
float a = 0.3;//acceleration
float f = 0.2;//frictional force

//constants
color EARTH = color(87, 62, 29);
color FIRE = color(212, 8, 8);
color WATER = color(54, 143, 199);
color AIR = color(212, 236, 250);

//initialization stuff
Room r;
Player Aang;
Dungeon LEVEL;
int menuTextMode = 0;
int currentRoom = 35; //there's no way to tell the starting pos fro a get method, so i'm using the hard-coded start of generation

void setup() {
  size(1000, 800);
  //startNewGame();
  //size(1000, 800);
  //loadPixels();
  //r = new Room(1);//  change later  //
  //Aang = new Player();
  //LEVEL = new Dungeon(1);
}

void draw() {
  if (dead) {
    gameSaved=false;//should move that to the player's die method, honestly, but then it's two files to push
    showDeathScreen();
  } else if (menu) {
    //menu screen
    menu();
  } else if (pause) {
    //pause screen
    pauseGame();
  } else {
    //check for door
    if (r.floor[(int)Aang.getY()][(int)Aang.getX() + Aang.getR() + 1] == -2) {//right
      currentRoom += 10;
      r = LEVEL.get(currentRoom);
      camC = 0;
      Aang.setX(wt + Aang.getR() + 2);
    }
    if (r.floor[(int)Aang.getY()][(int)Aang.getX() - Aang.getR() - 1] == -2) {//left
      currentRoom -= 10;
      r = LEVEL.get(currentRoom);
      camC = r.COLS-width;
      Aang.setX(r.COLS - wt - Aang.getR() - 2);
    }
    if (r.floor[(int)Aang.getY() + Aang.getR() + 1][(int)Aang.getX()] == -2) {//down
      currentRoom += 1;
      r = LEVEL.get(currentRoom);
      camR = 0;
      Aang.setY(wt + Aang.getR() + 2);
    }
    if (r.floor[(int)Aang.getY() - Aang.getR() - 1][(int)Aang.getX()] == -2) {//up
      currentRoom -= 1;
      r = LEVEL.get(currentRoom);
      camR = r.ROWS-height;
      Aang.setY(r.ROWS - wt - Aang.getR() - 2);
    }
    
    //display floor
    for (int i = (int)camR; i < height+(int)camR; i++) {
      for (int j = (int)camC; j < width+(int)camC; j++) {
        if (r.floor[i][j] == -1) {
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

    if (LEVEL.explored[currentRoom%10-1][currentRoom/10]==null) {
      LEVEL.explored[currentRoom%10-1][currentRoom/10] = r;
    }

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
    
    LEVEL.displayMiniMap();
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
  if (key == 'p' && !dead && !menu) { //i'll find a diff/better key later. esc, maybe?
    //background(90);
    pause=!pause;
  }
  //need map key
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
      if (!gameSaved){
        startNewGame();
      }
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
  if (pause) {
    if (mouseX > width/2-110 && mouseX < width/2+105 && mouseY > 3*height/5-30 & mouseY < 3*height/5+5) {
      gameSaved=true;
      pause=false;
      menu=true;
    } 
  }
}

void startNewGame() {
  loadPixels();
  LEVEL = new Dungeon(2);
  r = LEVEL.get(currentRoom);//  change later  //
  camR = 200;
  camC = 250;
  Aang = new Player();
}
