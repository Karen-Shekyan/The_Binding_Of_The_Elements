import java.util.*;

class Hurtbox {
  float radius;
  float xPos;
  float yPos;

  public Hurtbox(float x, float y, float r) {
    xPos=x;
    yPos=y;
    radius = r;
  }

  void debugShowHurtbox(){
    fill(255);
    ellipse(xPos,yPos,2*radius,2*radius);
  }
  
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
}
