import java.util.*;

public class Trinket implements Item{
  float xPos;
  float yPos;
  float radius;
  Room room;
  Hitbox areaOfEffect;
  int type;
  int price = 0;
  //static Collection<Integer> availableTypes = new ArrayList<Integer>(); 
  //need to make some static, shuffleable way to store the remaining usable types
  
  public Trinket(float x, float y, Room r) {
    xPos = x;
    yPos = y;
    room = r;
    areaOfEffect = new Hitbox(x,y,0,0,15,r);
    //this.type = type;
    this.type = availableTrinketTypes.poll();
    //how to prevent a trinket that's already been made from being made
  }
  
  public Trinket(float x, float y, Room r, int price) {
    xPos = x;
    yPos = y;
    room = r;
    areaOfEffect = new Hitbox(x,y,0,0,15,r);
    //this.type = type;
    this.type = availableTrinketTypes.poll();
    //how to prevent a trinket that's already been made from being made
    
    this.price = price;
  }
  //maxHealth up, maxHelath up and one heal, maxHealth up and full heal, speed up, damage up, flat damage bonus(?), tear cooldown down, tear speed up, tear size increase, double invin, [more to come]
  
  void display() {
    fill(230,230,255);
    ellipse(xPos-camC,yPos-camR,30,30);
    textSize(10);
    fill(10);
    text(""+type,xPos-camC,yPos-camR);
    
    if (price != 0) {
      text("" + price, xPos, yPos+20);
    }
  }
  //need to make it continue to display even after it's picked up (in the pause menu)
  void display(int x) {
    fill(230,230,255);
    ellipse(250+40*x,250+x/(width-500),30,30);
    textSize(10);
    fill(10);
    text(""+type,250+40*x,250+x/(width-500));
  }
  
  void effect(Player p) {
    Aang.trinkets.add(this);
    switch (type) {
      case 0:
        Aang.increaseMaxHearts(1);
        //grant an empty heart container
      break;
      case 1:
        Aang.increaseMaxHearts(1);
        Aang.heal(2);
        //grant a filled heart container
      break;
      case 2:
        //grant a heart container and heal to max
        Aang.increaseMaxHearts(1);
        Aang.heal(100); //i know this is lazy but it works
      break;
      case 3:
        //wanted to do speed up, it might be near impossible. but i'll leave the slot for now
        maxV += .5;
        a += .1;
      break;
      case 4: //   hypersynergy
        Aang.damageIncrease+=0.1;
        //up damage
      break;
      case 5:
        Aang.damageFlatIncrease++;
        //flat damage increase
      break;
      case 6:
        Aang.tearCooldownMultiplier-=0.15;
      break;
      case 7:
        Aang.tearSpeedMultiplier*=1.1;
      break;
      case 8:
        Aang.tearSizeMultiplier*=1.25;
      break;
      case 9:
        Aang.invinFactor += 0.5;
      break;
    }
    room.items.remove(this);
    //when/if i make fragile trinkets, i need to have the code to remove them from the player list (reminder to me) - not the best place for the note tbh
  }
  
  boolean isTouching(Player p) {
    return areaOfEffect.isTouching(p);
  }
  
  int getType() {
    return type;
  }
  
  int getPrice() {
    return price;
  }
}
