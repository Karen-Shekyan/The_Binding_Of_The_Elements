public class Heart implements Item {
  int health;
  int healthType; /*0 is normal health, 1 is spririt health, used ints because we might have more later */
  float x;
  float y;
  Hitbox areaOfEffect;
  Room room;
  
  public Heart(float x_, float y_, Room r) {
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
    
    room = r;
    areaOfEffect = new Hitbox(x,y,10,0,0, room);
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
    println("effect");
    if (healthType==0){
      //heal player
      p.heal(health);
    } else {
      //add to the spirit health
      p.addTempHealth(health);
    }
    room.items.remove(this);    
  }
  
  boolean isTouching(Player p) {
    return areaOfEffect.isTouching(p);
  }
}
