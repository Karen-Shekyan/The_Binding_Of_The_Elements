interface Item{
  void effect(Player p);
  void display();
  boolean isTouching(Player p);
  int getPrice();
}
