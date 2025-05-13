# Pathfinding Previews;
<hr>
<h2>Update 1</h2>
I've been working on creating an A* pathfinding system inspired by the game 'Gladius (2003)'. It's been a long process since I first started. although it still has some adjustments, it's turning out pretty well by far. I want to show off 2 pictures that are result of what I have by far;
<p align="center"><br>
  <img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Hugged_Pathfinding.png" hspace="5">
  <img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Curve_Pathfinding.png" hspace="5">
</p>

<hr>
<h2>Update 2</h2>
After some time after creating the A* pathfinding system, I created a simple function that chooses random cell indexes to set the cell type to 'None', which in other words is untraversable cells. This way, we can test the A* pathfinding to make sure that it actually does avoid cells that can't be traversed as seen below.
<p align="center"><br><img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Blocked_Pathfinding.png"></p>

<hr>
<h2>Update 3</h2>
Even though I already have made this part of the pathfinding possible, I wanted to show off a grid mainly filled with brown cells(Crates). You can see below that the image, even though almost fully covered with crates, is still traversable. All these crates are only at a height of 1 meaning that any height that has a height difference of 1 from the current cell and the next cell, that means the cell is climbable and still can be traversed.
<p align="center"><br><img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Crate_Pathfinding.png"></p>

<hr>
<h2>Update 4</h2>
So more progress was made, even though not visible visually but more under the hood. This currently is working in the direction of allowing visuals for the player to see how their movement path appears when they choose to move their character to a specific cell.
<p align="center"><br><img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Arrow_Pathfinding.png"></p>


<hr>
<h2>Update 5</h2>
So as you may have noticed that aren't looking top down on a white grid anymore, we are looking at a different perspective with more detail. What you see here is a more inline concept of a map. Now, the crates are still random just for the testing phase of the pathfinding, but you can see that we now have the arrows moving on top of the crate. Whenever the path needs to climb a crate to reach it's destination, you can see the arrows moving on top of it as well. This is to make sure that the path isn't obscurred. There are still more to do but for now, we have an actual detailed preview
<p align="center"><br><img width="840" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Detailed_Pathfinding.png"></p

<hr>
<h2>Update 6</h2>
The first thing you will notice is the arrows and the arrows going over 2 crates. I was able to fix the path to make it be able to move along the top of multiple crates so now it doesn't go back down to the ground when there is a crate present. A code change was made to remove custom waypoints and to just use the cell objects to form the path, this in turn allows us to expand the path so that if other properties or anything related to the cell object can be used for determining the path. In the second image, you can see crates with more than 1 crate stacked on top of it, you can also see that steps is possible with my pathfinding, which means that climbing up cells and walking up cells is possible if the height from cell A to cell B is valid climbing height.
<p align="center"><br>
  <img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/CrateDouble_Pathfinding.png" hspace="5">
  <img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/CrateSteps_Pathfinding.png" hspace="5">
</p>
