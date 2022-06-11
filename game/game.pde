import java.util.*;

//display constants
int wt = 100;
float camR = 200;//corresponds to y
float camC = 250;//corresponds to x

//screen variables
boolean dead = false;
boolean menu = true;
boolean pause;
boolean gameSaved;
boolean bigMap;
boolean endCredits;
int endScreenTime;

//controls for Player
boolean R = false;
boolean L = false;
boolean U = false;
boolean D = false;
boolean MOUSE = false;

boolean godMode = false;

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
int bossRoom;

//sprites
PShape redHeart;
PShape halfHeart;
PShape spiritHeart; //the temp health
PShape halfSpiritHeart;
PShape emptyHeart;
PShape coin;
PShape crown;
PShape skull;
PShape wasd;
PShape mouseAim;
PShape typeWeakness;
PShape weaponIndicator;
PShape typeStrength;
PShape playerSprite;
PShape touchySprite;
PShape shootySprite;
PShape stabbySprite;
PShape swingySprite;
PShape miniBossSprite;
//PShape aangEarth;
//PShape aangFire;
//PShape aangWater;
//PShape aangAir;

LinkedList<Integer> availableTrinketTypes;

void setup() {
  size(1000, 800);

  //for form, i'll initialize them in here but declare them outide
  redHeart = loadShape("red-heart.svg");
  halfHeart = loadShape("half-red-heart.svg");
  spiritHeart = loadShape("blue-heart.svg"); //the temp health
  halfSpiritHeart = loadShape("half-heart-jagged.svg");
  emptyHeart = loadShape("empty-heart.svg");

  coin = loadShape("textless-coin.svg");
  crown = loadShape("crownyy.svg");
  skull = loadShape("skull.svg");

  wasd = loadShape("was.svg");
  mouseAim = loadShape("mouse-aim.svg");
  typeWeakness = loadShape("attribute chart-2.svg");
  weaponIndicator = loadShape("weaponType.svg");
  typeStrength = loadShape("attribute chart-3.svg");

  playerSprite = loadShape("aang.svg");
  touchySprite = loadShape("enemyTouch.svg");
  shootySprite = loadShape("enemyTouch-2.svg");
  stabbySprite = loadShape("enemyTouch-3.svg");
  swingySprite = loadShape("enemyTouch-4.svg");
  miniBossSprite = loadShape("enemyTouch-5.svg");
  //aangEarth = loadShape("aang-earth.svg");
  //aangWater = loadShape("aang-water.svg");
  //aangFire = loadShape("aang-fire.svg");
  //aangAir = loadShape("aang-air.svg");

  //startNewGame();
  //size(1000, 800);
  //loadPixels();
  //r = new Room(1);//  change later  //
  //Aang = new Player();
  //LEVEL = new Dungeon(1);
  
  availableTrinketTypes = new LinkedList<Integer>();
  availableTrinketTypes.add(0);
  availableTrinketTypes.add(1);
  availableTrinketTypes.add(2);
  availableTrinketTypes.add(3);
  availableTrinketTypes.add(4);
  availableTrinketTypes.add(5);
  availableTrinketTypes.add(6);
  availableTrinketTypes.add(7);
  availableTrinketTypes.add(8);
  availableTrinketTypes.add(9);
  Collections.shuffle(availableTrinketTypes);
}

void draw() {
  if (dead) {
    gameSaved=false;//should move that to the player's die method, honestly, but then it's two files to push
    showDeathScreen();
  } else if (menu) {
    //menu screen
    menu();
  } else if (endCredits) {
    showEndScreen();
  } else if (pause) {
    //pause screen
    pauseGame();
  } else {
    //check for door
    if (godMode || r.enemies.size() == 0) {
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
    }

    //display floor
    for (int i = (int)camR; i < height+(int)camR; i++) {
      for (int j = (int)camC; j < width+(int)camC; j++) {
        if (r.floor[i][j] == -1) { //wall
          pixels[width*(i-(int)camR) + (j-(int)camC)] = color(0);
        } else if (r.floor[i][j] == -2) { //door
          pixels[width*(i-(int)camR) + (j-(int)camC)] = color(255);
        } else if (r.floor[i][j] == -3) { //hidden door
          pixels[width*(i-(int)camR) + (j-(int)camC)] = color(1);
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

    if (r.roomType < 0) {
      showInstructions();
    }

    if (LEVEL.explored[currentRoom%10-1][currentRoom/10]==null) {
      LEVEL.explored[currentRoom%10-1][currentRoom/10] = r;
    }

    for (int i = 0; i < r.enemies.size(); i++) {//this is contact damage. Always deals 1.
      Enemy guy = r.enemies.get(i);
      guy.move();
      guy.display();
      if (guy.getTouchZone().isTouching(Aang)) {//             contact knockback HERE             //
        Aang.takeDamage(1);
        float dx = (Aang.getX() - guy.getX()) / dist(Aang.getX(), Aang.getY(), guy.getX(), guy.getY());
        float dy = (Aang.getY() - guy.getY()) / dist(Aang.getX(), Aang.getY(), guy.getX(), guy.getY());
        Aang.knockback(dx * 4.0, dy * 4.0);
      }
      guy.attack();
      guy.decrementStun();
    }


    for (int j = 0; j < r.playerBullets.size(); j++) {
      Bullet bullet = r.playerBullets.get(j);
      //not working rn, bullet gets no velocity
      bullet.move();

      for (int i = 0; i < r.enemies.size(); i++) {
        Enemy guy = r.enemies.get(i);

        if (bullet.isTouching(guy)) {
          guy.takeDamage(bullet.getDam());
          r.playerBullets.remove(bullet);
        }
      }
      bullet.display();
    }

    for (int i = 0; i < r.enemyBullets.size(); i++) {
      Bullet bullet = r.enemyBullets.get(i);
      bullet.move();

      if (bullet.isTouching(Aang)) {
        Aang.takeDamage(bullet.getDam());
        Aang.knockback(bullet.vx * 0.8, bullet.vy * 0.8);       //knockback applied to player here. Mess with the numbers more.
        r.enemyBullets.remove(bullet);
      }
      bullet.display();
    }

    //should maybe add some other additional condition to trigger the end screen. what if the player wants to backtrack (idk why, there's no real point -- i guess later you might want to check the shop out or something)
    if (LEVEL.get(bossRoom).enemies.size()==0) {
      endCredits = true;
      endScreenTime = 0;
    }
    
    for (int i=0; i<r.items.size(); i++) {
      r.items.get(i).display();
      if (r.items.get(i).isTouching(Aang)) {
        r.items.get(i).effect(Aang);
      }
    }
    
    //if (r.roomType==4 && r.enemies.size()!=0){
    //  r.enemies.get(0).drawHealthBar();
    //}

    Aang.move();
    Aang.display();
    if (MOUSE) {
      Aang.attack();
    }
    Aang.decrementAttackCD();
    Aang.decrementStun();
    Aang.decrementInvin();

    LEVEL.displayMiniMap();
    
    for (int i = 0; i < r.activeBombs.size(); i++) {
      r.activeBombs.get(i).display();
    }
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
  if (keyCode == TAB) { //map size toggle
    bigMap =! bigMap;
  }
  if (key == 'g') {
    godMode = !godMode;
  }
  if (key == 'k' && godMode) {
    r.killAll();
  }
  if (key == 'c' && godMode) {
    r.clearBullets();
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
  if (key == 'f') {
    Aang.useBomb();
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
      if (!gameSaved) {
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
  if (endCredits && endScreenTime > 365) {
    //button
    if (mouseX > width/2 - 100 && mouseX < width/2+90 && mouseY < 2*height/3 + 65 && mouseY > 2*height/3 + 35) {
      //menu=false;
      startNewGame();
      endCredits = false;
    }
    //button
    if (mouseX > width/2 - 125 && mouseX < width/2+110 && mouseY < 4*height/5 + 35 && mouseY > 4*height/5 + 5) {
      menu = true;
      endCredits = false;
    }
  }
}

void startNewGame() {
  loadPixels();
  LEVEL = new Dungeon(1);
  currentRoom = 35;
  r = LEVEL.get(currentRoom);//  change later  //
  camR = 200;
  camC = 250;
  Aang = new Player();
  vx = 0;
  vy = 0;
}
