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
- wrote Enemy interface, Hitbox class, Hurtbox class, and DummyEnemy class.
- did not code the isTouching method int Hitbox because an issue with the hitboxes was brought up by Karen
- did not code die method because some necessary instance variables in the Room class are not properly done (list of enemies)
- methods in DummyEnemy class were defined as needed for a non-moving test enemy (move is blank, attack is blank, etc.)

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
- wrote TouchyEnemy class, which moves towards the player and deals contact damage
- tried making a Bullet class. they deal damage and are released properly, but don't move (so they're like permanent mines)

Karen Shekyan:
- Added Dungeon class. It generates properly, allegedly. Special rooms generate as they should.
- Debug methods and print statements added.
- Game now generates dungeon on setup.

###### 5/23/22
Jonathan Shavit:
- thought i pulled, but didn't, and ended up basically coding what Karen did

Karen Shekyan:
- Fixed bullets, now functional. Move properly and deal damage.
- Player attacks aim at mouse.
- Changed control scheme: use WASD and mouse now.
- Strange bug with Touchy. ~~To be fixed today.~~ Touchy now takes proper damage, but the hitbox doesn't detect distance correctly. This is the result of using a different coordinate system for the Player. Must **carefully** read code and change this everywhere.

###### 5/24/22


Jonathan Shavit:
- made a death screen, a pause screen, and a menu screen (really a title screen)

Karen Shekyan:
- Fixed Touchy and the coordinate system. Now ALL positions are relative to the ROOM.
