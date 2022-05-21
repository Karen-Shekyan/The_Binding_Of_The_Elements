int wt = 100;
float camR = 200;
float camC = 250;
boolean dead = false;
//control movement for Player
boolean R = false;
boolean L = false;
boolean U = false;
boolean D = false;
//speeds of the Player
float vx = 0.0;
float vy = 0.0;
float maxV = 4.0;
// forces on Player
float a = 0.3;//acceleration
float f = 0.2;//frictional force
Room r;
Player Aang;
color EARTH = color(87, 62, 29);
color FIRE = color(212, 8, 8);
color WATER = color(54, 143, 199);
color AIR = color(212, 236, 250);

void setup() {
  size(1000, 800);
  loadPixels();
  r = new Room(1);//  change later  //
  Aang = new Player();
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

  Aang.move();
  Aang.display();
}

//updating booleans for each arrow key
void keyPressed() {
  if (keyCode == RIGHT) {
    R = true;
  }
  if (keyCode == LEFT) {
    L = true;
  }
  if (keyCode == UP) {
    U = true;
  }
  if (keyCode == DOWN) {
    D = true;
  }
}

void keyReleased() {
  if (keyCode == RIGHT) {
    R = false;
  }
  if (keyCode == LEFT) {
    L = false;
  }
  if (keyCode == UP) {
    U = false;
  }
  if (keyCode == DOWN) {
    D = false;
  }
}
