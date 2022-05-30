void showInstructions() {
  shape(wasd, 550-camC, 250-camR, 400, 400);
  fill(20);
  textSize(40);
  text("WASD to move", 600-camC, 550-camR);
  
  shape(mouseAim, 1050-camC, 250-camR, 225, 225);
  textSize(30);
  text("Aim with your\nmouse/trackpad and\nclick to fire", 1050-camC, 550-camR);
  
  shape(weaponIndicator, 150-camC, 250-camR, 250, 250);
  //textSize(30);
  //fill(20);
  text("Weapon mode indicated\n by circle in character", 125-camC, 550-camR);
  
  shape(typeWeakness, 150-camC, 650-camR, 400, 400);
  shape(typeStrength, 600-camC, 650-camR, 400, 400);
  text("The floor interacts with your weapon! \nDamage is increased or reduced depending how \nyour weapon's color interacts with the floor's", 150-camC, 975-camR);
  
}
