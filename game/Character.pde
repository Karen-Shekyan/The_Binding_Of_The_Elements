interface Character {
  void takeDamage(int damage);
  void attack();
  void move();
  void die();
  void display();
  void knockback(float x, float y);
  void moveHurt();//         subject to change         //
  void moveHit();
  void setStun(int stun);
  int getStun();
  void decrementStun();
  float getX();
  float getY();
  ArrayList<Hurtbox> getHurtboxes();
}
