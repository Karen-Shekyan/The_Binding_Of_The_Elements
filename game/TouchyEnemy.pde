class TouchyEnemy implements Enemy {
  private int health;
  private float radius = 20;
  public float attack;
  private float xPos;
  private float yPos;
  private int stunTimer = 0;
  private ArrayList<Hurtbox> body = new ArrayList<Hurtbox>();
  private Hitbox touchZone;
  public Room room;

  public TouchyEnemy(Room a) {
    attack = 1;
    xPos = 350;
    yPos = 350;
    health = 30;
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
    float d = dist(Aang.getX(),Aang.getY(),getX(),getY());
    xPos += 3.0 * (Aang.getX()-getX())/d;
    yPos += 3.0 * (Aang.getY()-getY())/d;
    moveHurt();
    moveHit();
  }

  void die() {
    dropLoot();

    //enemy removes itself from the enemies list of the room it's in
    room.enemies.remove(this);
  }

  void display() {
    stroke(0);
    strokeWeight(1);
    
    fill(105, 66, 245);
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
    
    //fill(255);//    draw hurtbox    //
    //ellipse(body.get(0).getX()-camC,body.get(0).getY()-camR,2*radius,2*radius);
    
    ////    draw hitbox    //
    //fill(0,255,0);
    //ellipse(touchZone.getX()-camC,touchZone.getY()-camR,2*radius,2*radius);

    fill(0);
    textSize(10);
    text(""+health,xPos-camC, yPos-camR);
  }

  void knockback(float x, float y) {
    //not working on this yet
  }

  void moveHurt() {
    for (int i = 0; i < body.size(); i++) {
      body.get(i).setX(getX());
      body.get(i).setY(getY());
    }
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
    stunTimer = Math.max(0,stunTimer-1);
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
