class ShootyEnemy implements Enemy {
  private int health;
  private float radius = 20;
  public float attack;
  private float xPos;
  private float yPos;
  private int stunTimer = 0;
  private ArrayList<Hurtbox> body = new ArrayList<Hurtbox>();
  private Hitbox touchZone;
  public Room room;

  public ShootyEnemy (Room a) {
    attack = 1;
    xPos = 550;
    yPos = 350;
    health = 20;
    room = a;

    body.add(new Hurtbox(xPos, yPos, radius));
    touchZone = new Hitbox(xPos, yPos, radius, 0, 0, room);
  }
  
  void takeDamage(int damage) {
    health -= damage;
    if (health <= 0) {
      die();
    }
  }
  
  void attack() {///////////////////////
    
  }
  
  void move() {/////////////////////////
    
  }
  
  void die() {
    dropLoot();

    //enemy removes itself from the enemies list of the room it's in
    room.enemies.remove(this);
  }
  
  void display() {
    fill(0,150,150);
    ellipse(xPos-camC, yPos-camR, 2*radius, 2*radius);
    
    fill(0);
    textSize(10);
    text(""+health,xPos-camC, yPos-camR);
  }
  
  void knockback(float x, float y) {
    
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
  
  float getX() {
    return xPos;
  }
  
  float getY() {
    return yPos;
  }
  
  ArrayList<Hurtbox> getHurtboxes() {
    return body;
  }

  void dropLoot() {
    
  }
  Hitbox getTouchZone() {
    return touchZone;
  }
}
