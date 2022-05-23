interface Enemy extends Character {
  void dropLoot();
  Hitbox getTouchZone();
  
  //an attempt at forcing processing to accept my isTouching method taking an Enemy as a parameter (i still think we should use an abstract class)
  Hurtbox[] getHurtboxes();
}
