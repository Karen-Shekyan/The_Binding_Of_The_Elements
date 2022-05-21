class DummyEnemy implements Enemy{
  private int health;
  private float radius = 20;
  private float attack=0;
  private float xPos;
  private float yPos;
  private int stunTimer = 0;
  Room room;
  
  DummyEnemy(Room a){
    attack=1;
    xPos = 600;
    yPos = 600;
    health = 50;
    room = a;
  }
  void takeDamage(int damage){
    health-=damage;
  }
  void attack(){}
  void move(){}
  void die(){
    if (health<=0){} //enemy dies when hp is 0 or below
    //enemy removes itself from the enemylist of the room it's in
  }
  void display(){
    fill(255,150,10);
    ellipse(xPos,yPos,2*radius,2*radius);
  }
  void knockback(float x, float y){
    xPos+=x;
    yPos+=y;
  }
  
  void moveHurt(){}
  void moveHit(){}
  void setStun(int stun){
    stunTimer = stun;
  }
  int getStun(){
    return stunTimer;
  }
  void decrementStun(){
    stunTimer--;
  }
  void dropLoot(){
    //nothing yet
  }
}
