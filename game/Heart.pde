public class Heart {
  int health;
  int healthType; /*0 is normal health, 1 is spririt health, used ints because we might have more later */
  float x;
  float y;
  
  public Heart(float x_, float y_) {
    double rng = Math.random();
    if (rng<0.7){
      healthType = 0;
    } else {
      healthType = 1;
    }
    
    rng = Math.random();
    if (rng<0.85){
      health = 1;
    } else {
      health = 2;
    }
    
    x = x_;
    y = y_;
  }
  
  void display() {
    if (health==1 && healthType==0) {
      shape(halfHeart,x-10-camC,y-10-camR,20,20);
    } else if (health==2 && healthType==0) {
      shape(redHeart,x-10-camC,y-10-camR,20,20);
    } else if (health==1 && healthType==1) {
      shape(halfSpiritHeart,x-10-camC,y-10-camR,20,20);
    } else if (health==2 && healthType==1) {
      shape(spiritHeart,x-10-camC,y-10-camR,20,20);
    } else {
      //shape(emptyHeart,width/2,height/2,90,90);
      //here if i need to test if something is slipping through the cracks
    }
  }
  
  void effect(Player p) {
    if (healthType==0){
      //heal player
    } else {
      //add to the spirit health
    }
  }
}
