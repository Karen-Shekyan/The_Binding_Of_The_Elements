# The_Binding_Of_The_Elements

### Group Name: Circle Enjoyers
### Group Members: Jonathan Shavit, Karen Shekyan

### Project Summary:
This is a game similar to The Binding of Isaac in that it’s a dungeon-based roguelike shooter. The dungeon will be procedurally generated with the same algorithm used in the game, and each room’s floor will be procedurally generated using Perlin noise, colored with 4 colors corresponding to the four elements: water, earth, fire, air. The player’s weapon will randomly swap between 4 modes after a fixed amount of time, each of which interacts differently with the terrain. The game will also have different enemy types, each with different movement strategies and attack styles. There will be difficulty scaling in the form of 2 levels, the first containing less rooms and a miniboss, and the second containing more rooms and a final boss. Each floor will also have a treasure room, secret room, and shop, just as in the original game.


### Link to design document:
https://docs.google.com/document/d/14aSD5MYKt3-_xdbgievmI_6Ht4iWH8zdrucnTaJyMbY/edit?usp=sharing

5/20 Karen Shekyan: Added basic stuff to *game* sketch, made Room class, Character interface, Player class. Completed basic methods (as defined by the "Proof of Concept" section) for Player other than attack() and those for Room. Room and Player have features to be removed or changed later, kept for now to debug/test. Room constructor WILL be changed to create better coloration.
