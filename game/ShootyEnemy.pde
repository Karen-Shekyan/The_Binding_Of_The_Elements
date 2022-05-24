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

  public ShootyEnemy () {
    
  }
  
  void takeDamage(int damage) {
    
  }
  
  void attack() {
    
  }
  
  void move() {
    
  }
  
  void die() {
    
  }
  
  void display() {
    
  }
  
  void knockback(float x, float y) {
    
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
