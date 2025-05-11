# Pathfinding Previews;
<hr>
<h2>Update 1</h2>
I've been working on creating an A* pathfinding system inspired by the game 'Gladius (2003)'. It's been a long process since I first started. although it still has some adjustments, it's turning out pretty well by far. I want to show off 2 pictures that are result of what I have by far;

<p align="center">
  <img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Hugged_Pathfinding.png" hspace="5">
  <img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Curve_Pathfinding.png" hspace="5">
</p>

<hr>
<h2>Update 2</h2>
After some time after creating the A* pathfinding system, I created a simple function that chooses random cell indexes to set the cell type to 'None', which in other words is untraversable cells. This way, we can test the A* pathfinding to make sure that it actually does avoid cells that can't be traversed as seen below.
<p align="center"><img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Blocked_Pathfinding.png"></p>

<hr>
<h2>Update 3</h2>
Even though I already have made this part of the pathfinding possible, I wanted to show off a grid mainly filled with brown cells(Crates). You can see below that the image, even though almost fully covered with crates, is still traversable. All these crates are only at a height of 1 meaning that any height that has a height difference of 1 from the current cell and the next cell, that means the cell is climbable and still can be traversed.
<p align="center"><img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Crate_Pathfinding.png"></p>

<hr>
<h2>Update 4</h2>
So more progress was made, even though not visible visually but more under the hood. This currently is working in the direction of allowing visuals for the player to see how their movement path appears when they choose to move their character to a specific cell.
<p align="center"><img width="420" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Arrow_Pathfinding.png"></p>


<hr>
<h2>Update 5</h2>
So as you may have noticed that aren't looking top down on a white grid anymore, we are looking at a different perspective with more detail. What you see here is a more inline concept of a map. Now, the crates are still random just for the testing phase of the pathfinding, but you can see that we now have the arrows moving on top of the crate. Whenever the path needs to climb a crate to reach it's destination, you can see the arrows moving on top of it as well. This is to make sure that the path isn't obscurred. There are still more to do but for now, we have an actual detailed preview
<p align="center"><img width="840" height="420" src="https://github.com/RandomGGRandy/World_Of_Heroes/blob/main/Images/Detailed_Pathfinding.png"></p
