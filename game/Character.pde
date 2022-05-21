interface Character {
  void takeDamage(int damage);
  void attack();
  void move();
  void die();
  void display();
  void knockback(float x, float y);
  void moveHurt();//         subject to change         //
  void moveHit();
  void setStun();
  void getStun();
  void decrementStun();
}
