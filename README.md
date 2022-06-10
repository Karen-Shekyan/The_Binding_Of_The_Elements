# The_Binding_Of_The_Elements

### Group Name: Circle Enjoyers
### Group Members: Jonathan Shavit, Karen Shekyan

### Project Summary:
This is a game similar to The Binding of Isaac in that it’s a dungeon-based roguelike shooter. The dungeon will be procedurally generated with the same algorithm used in the game, and each room’s floor will be procedurally generated using Perlin noise, colored with 4 colors corresponding to the four elements: water, earth, fire, air. The player’s weapon will randomly swap between 4 modes after a fixed amount of time, each of which interacts differently with the terrain. The game will also have different enemy types, each with different movement strategies and attack styles. There will be difficulty scaling in the form of 2 levels, the first containing less rooms and a miniboss, and the second containing more rooms and a final boss. Each floor will also have a treasure room, secret room, and shop, just as in the original game.



### Link to design document:
https://docs.google.com/document/d/14aSD5MYKt3-_xdbgievmI_6Ht4iWH8zdrucnTaJyMbY/edit?usp=sharing


### Devlog
###### 5/20/22
Jonathan Shavit:
- Wrote Enemy interface, Hitbox class, Hurtbox class, and DummyEnemy class.
- Did not code the isTouching method int Hitbox because an issue with the hitboxes was brought up by Karen
- Did not code die method because some necessary instance variables in the Room class are not properly done (list of enemies)
- Methods in DummyEnemy class were defined as needed for a non-moving test enemy (move is blank, attack is blank, etc.)

Karen Shekyan:
- Added basic stuff to *game* sketch, made Room class, Character interface, Player class.
- Completed basic methods (as defined by the "Proof of Concept" section) for Player other than attack() and those for Room.
- Room and Player have features to be removed or changed later, kept for now to debug/test. Room constructor WILL be changed to create better coloration.

###### 5/21/22
Karen Shekyan:
- Fixed merging issues due to not using --no-ff flags. Pushed Jonathan's code and devlog from 5/20 to origin.
- Made enemies do contact damage. Added to enemy interface to allow for this. Knockback does NOT get dealt from contact damage as of yet.
- Enemies are now displayed.

###### 5/22/22
Jonathan Shavit:
- Wrote TouchyEnemy class, which moves towards the player and deals contact damage.
- Tried making a Bullet class. they deal damage and are released properly, but don't move (so they're like permanent mines).

Karen Shekyan:
- Added Dungeon class. It generates properly, allegedly. Special rooms generate as they should.
- Debug methods and print statements added.
- Game now generates dungeon on setup.

###### 5/23/22
Jonathan Shavit:
- Thought I pulled, but didn't, and ended up basically coding what Karen did.

Karen Shekyan:
- Fixed bullets, now functional. Move properly and deal damage.
- Player attacks aim at mouse.
- Changed control scheme: use WASD and mouse now.
- Strange bug with Touchy. ~~To be fixed today.~~ Touchy now takes proper damage, but the hitbox doesn't detect distance correctly. This is the result of using a different coordinate system for the Player. Must **carefully** read code and change this everywhere.

###### 5/24/22

Jonathan Shavit:
- Made a death screen, a pause screen, and a menu screen (really a title screen).
- Made a minimap that shows dungeon layout, current room, and explored rooms (no indicators for special rooms and the like yet though).

Karen Shekyan:
- Fixed Touchy and the coordinate system. Now ALL positions are relative to the ROOM.
- ShootyEnemy implemented. Attacks properly. Moves and strafes but very jittery, polish later.
- Made bullets store the damage they deal. They also get placed into the proper room list when created (need to remove an unnecessary feature later).

###### 5/25/22

Jonathan Shavit:
- Slightly altered minimap to better match the original game's style.
- Added markers to the minimap (boss, treasure, shop), which I *unwisely* hard-coded.
- Modified the pause menu to include the option to quit to menu.
- Made the game load your previous run when you click play after quitting to menu.
- Made some heart sprites. I spent way too long on those.

Karen Shekyan:
- Fixed Dungeon generating twice on start.
- Fixed minimap. Added translucent background to it. Made it display on top of everything else.

###### 5/26/22

Jonathan Shavit:
- Changed the HUD so it displays the heart sprites instead of using circles.
- Changed the minimap so it only displays explored rooms or rooms neighboring explored rooms. also added a debug version of the displayMiniMap method to outline unexplored rooms (and show their pins).

Karen Shekyan:
- Made doors generate in each room upon dungeon generation.
- Room transitions working properly! Doors have no texture, add later.

###### 5/27/22

Jonathan Shavit:
- Added a toggleable (on TAB press) expansion of the minimap.
- Wrote an end screen and made it trigger when all enemies in the boss room are killed.
- Made the end screen do a slow automatic text-progression thing (takes like 5~6 seconds) - might tweak later.
- Uploaded sprites for the minimap's pins/markers.
- Replaced some markers on the map with the appropriate sprites (i would've done all of them, but one sprite wouldn't load in. it'd throw a NullPointerException - but just that one).

Karen Shekyan:
- Made player get invincibility frames and get stunned upon taking damage.
- Made player receive knockback from bullets and from contact damage. The latter must be fixed.

###### 5/28/22

JonathanShavit:
- Figured out why the coin sprite wouldn't load in and fixed that (now the mimimap only uses sprites).
- Discovered a bug in the drawing of the 'crown' marker of the minimap (a small line is drawn diagonally from the 'crown' marker across the screen - it isn't intrusive, but it's there).

Karen Shekyan:
- Improved player knockback.

###### 5/29/22

Jonathan Shavit:
- Fixed the bug in the crown sprite, but found a similar (but smaller) one in the skull sprite.
- Added some images to use in game instructions.

Karen Shekyan:
- Added miniboss. They're slower, larger, have more health, and attack in a unique way. They spawn in the middle of the boss room of level 1. Also, their setStun method does nothing; this is intended.
- The number of enemies in each "normal" room is randomized between 4-6 (on level 1, change later for level 2).
- The location of enemies is also randomized.

###### 5/30/22

Jonathan Shavit:
- Added an indicator of the player's weapon mode/type to the player's display method (a little colored circle on the player).
- Added more images to use in game instructions.
- Filled the first room with game instructions.

Karen Shekyan:
- Polished Shooty's and Mini's brains. They are no longer jittery.
- Shooty and Mini also have collision detection with the walls.

###### 5/31/22

Jonathan Shavit:
- Added some enemy and player sprites.

###### 6/1/22

Jonathan Shavit:
- Added a method, changeWeaponMode(), to Player class, that gets called in its move, and randomly switches the Player's weapon mode every 180 frames (made the Player's weapon change mode after every 180 frames).
- Made the Player stop changing colors in accordance with weaponMode, and instead have a single unchanging sprite.
- Added a (tentative) textual display of weaponMode in the bottom left corner of the screen.

Karen Shekyan:
- Made StabbyEnemy. Behaves somewhat similarly to shooty (chases and strafes the player) but attacks with a "sword".
- Animated stabby's attacks and made them collide properly with the player.
- Changed strafe speed in shooty and stabby to be slower than chase speed.
- Set hard cap on knockback to prevent melee attacks from flinging the player into walls and doors at high speeds.

###### 6/2/22

Jonathan Shavit:
- Added a boolean check that prevents you from leaving the current room if it still has enemies.
- Added methods to Player for increasing its health (current health) and tempHealth.
- Added a Heart class that makes objects that can restore player health and disappear upon doing so.
- Made enemies have a certain chance of dropping a Heart upon death.
- I plan to make an Item interface to standardize the item methods.

Karen Shekyan:
- Randomized movements slightly for all enemies. They pick a direction to move in at random intervals. The direction is slightly randomized too.
- Made Swingy and animated their attack.

###### 6/3/22

Jonathan Shavit:
- Added Item interface, and made Heart implement it
- Changed the list of Hearts in Room to a list of Items, and updated code referencing those lists accordingly
- Added new sprites for Swingy, Stabby, and Mini
- Removed now unused sprites

Karen Shekyan:
- Messed around with numbers to make the game play better.

###### 6/4/22

Jonathan Shavit:
- Added a variable to the Player to keep track of how much money the Player has, and a method to increase it
- Added a display of Player's wealth to the HUD
- Updated enemies so they have an 85% change of increasing the Player's wealth by one unit of currency

###### 6/5/22

Karen Shekyan:
- Added Bomb class and made enemies drop bomb items.
- Made and animated ActiveBomb class: the type of bomb placed by player.
- ActiveBombs damage all characters. Currently they immediately kill enemies (not intended).
- Adjusted drop rates for all items.

###### 6/6/22

Karen Shekyan:
- Fixed instant kill bombs.
- Generated secret room using the original algorithm. Probably will update later to reduce load times. It also has no doors yet.
- Made hidden doors generate in rooms adjacent to the secret room.
- Bombs exploding near hidden doors open them.
- Found bug: bombs create doors to rooms that don't exist.

###### 6/7/22

Jonathan Shavit:
- Started coding Trinket class

###### 6/8/22

Jonathan Shavit:
- Finished coding Trinket class for now, might add more trinkets later.
- Made the Trinket constructor use a random element from a LinkedList of Integers (newly added to the game tab) for the Trinket type, rather than the parameter. Also made a Constructor that doesn't even take a parameter for type.
- Added another display method (taking a parameter) to be called from the PauseScreen for use in its display of possessed Trinkets, and updated PauseScreen to use it accordingly (and fixed textSize-related issues that resulted)
