interface Enemy extends Character {
  void dropLoot();
  Hitbox getTouchZone();
}
