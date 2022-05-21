class Hitbox{
  float radius;
  float xPos;
  float yPos;
  
  float getX(){
    return xPos;
  }
  float getY(){
    return yPos;
  }
  float getR(){
    return radius;
  }
  void setX(float x){
    xPos = x;
  }
  void setY(float y){
    yPos = y;
  }
  
  boolean isTouching(Character other){
    boolean anyTouching = false;
    return false;
  }
  float distance(Hurtbox other){
    return dist(getX(), getY(), other.getX(), other.getY());
  }
}
