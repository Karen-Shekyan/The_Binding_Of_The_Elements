class TouchyEnemy implements Enemy {
  private int health;
  private float radius = 20;
  private float attack;
  //    NOTE THIS IS THE POSITION IN THE ROOM, NOT ON THE SCREEN    //
  private float xPos;
  private float yPos;
  private int stunTimer = 0;
  private ArrayList<Hurtbox> body = new ArrayList<Hurtbox>();
  private Hitbox touchZone;
  public Room room;

  public TouchyEnemy(Room a) {
    attack=1;
    xPos = 400;
    yPos = 300;
    health = 50;
    //for when it deletes itself later
    room = a;
    body.add(new Hurtbox(xPos, yPos, radius));
    touchZone = new Hitbox(xPos, yPos, radius, 0, 0, room);
  }

  Hitbox getTouchZone() {
    return touchZone;
  }
  
  ArrayList<Hurtbox> getHurtboxes(){
    return body;
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
    float distance = dist(Aang.getX(), Aang.getY(), getX()-camC, getY()-camR);
    float movementScale = 3;
    xPos+=movementScale*(Aang.getX()-getX()+camC)/distance;
    yPos+=movementScale*(Aang.getY()-getY()+camR)/distance;
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
    fill(105, 66, 245);
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
    
    //fill(150);
    //ellipse(xPos,yPos,2*radius,2*radius);
  }

  void knockback(float x, float y) {// NOT HOW THIS WORKS. FIX LATER //
    //not working on this yet
  }

  void moveHurt() {
    //this should be looping through all the Hurtboxes in hurtboxes, i'll get back to that later
    for (int i = 0; i < body.size(); i++) {
      body.get(i).setX(getX()-camC);
      body.get(i).setY(getY()-camR);
    }
  }

  void moveHit() {
    touchZone.setX(getX()-camC);
    touchZone.setY(getY()-camR);
    
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
