class TouchyEnemy implements Enemy {
  private int health;
  private float radius = 20;
  private float attack;
  //    NOTE THIS IS THE POSITION IN THE ROOM, NOT ON THE SCREEN    //
  private float xPos;
  private float yPos;
  private int stunTimer = 0;
  Hurtbox[] hurtboxes;
  Hitbox touchZone;
  public Room room;

  public TouchyEnemy(Room a) {
    attack=1;
    xPos = 700;
    yPos = 300;
    health = 50;
    //for when it deletes itself later
    room = a;
    hurtboxes = new Hurtbox[1];
    hurtboxes[0] = new Hurtbox(xPos, yPos, radius);
    touchZone = new Hitbox(xPos, yPos, radius, 0, 0, room);
  }

  Hitbox getTouchZone() {
    return touchZone;
  }

  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      die();
    }
  }

  void attack() {
  }

  void move() {
    float distance = dist(Aang.getX(), Aang.getY(), getX(), getY());
    float movementScale = 5;
    xPos+=movementScale*=(Aang.getX()-getX())/distance;
    yPos+=movementScale*=(Aang.getY()-getY())/distance;
    moveHurt();
    moveHit();
  }

  void die() {
    //no loot to speak of yet, but the method should sit here just in case;
    dropLoot();

    //enemy removes itself from the enemies list of the room it's in
    room.enemies.remove(this);
  }

  void display() {
    fill(10, 150, 200);
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
  }

  void knockback(float x, float y) {// NOT HOW THIS WORKS. FIX LATER //
    //not working on this yet
  }

  void moveHurt() {
    //this should be looping through all the Hurtboxes in hurtboxes, i'll get back to that later
    hurtboxes[0].setX(getX());
    hurtboxes[0].setY(getY());
  }

  void moveHit() {
    touchZone.setX(getX());
    touchZone.setY(getY());
    
  }

  void setStun(int stun) {
    stunTimer = stun;
  }

  int getStun() {
    return stunTimer;
  }

  void decrementStun() {
    stunTimer--;
  }

  void dropLoot() {
    //nothing yet
  }

  float getX() {
    return xPos;
  }

  float getY() {
    return yPos;
  }
}
