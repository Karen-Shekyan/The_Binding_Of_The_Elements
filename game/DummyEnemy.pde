class DummyEnemy implements Enemy {
  private int health;
  private float radius = 20;
  private float attack = 0;
  //    NOTE THIS IS THE POSITION IN THE ROOM, NOT ON THE SCREEN    //
  private float xPos;
  private float yPos;
  private int stunTimer = 0;
  Hurtbox[] hurtboxes;
  Hitbox touchZone;
  public Room room;

  public DummyEnemy(Room a) {
    attack=1;
    xPos = 300;
    yPos = 300;
    health = 50;
    //for when it deletes itself later
    room = a;
    hurtboxes = new Hurtbox[1];
    hurtboxes[0] = new Hurtbox(xPos, yPos, radius);
    touchZone = new Hitbox(xPos, yPos, radius);
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
  }
  void die() {
    //enemy removes itself from the enemies list of the room it's in
    room.enemies.remove(this);
  }
  void display() {
    fill(255, 150, 10);
    //FIX THIS. WRONG POSITION COORDINATES
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
  }
  void knockback(float x, float y) {
    xPos+=x;
    yPos+=y;
    //i might need to subtract and not add
  }

  void moveHurt() {
  }
  void moveHit() {
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
}
