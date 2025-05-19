<h2>1: Create the grid using 'CreateGrid'</h2>

```
The grid will be set based on the given arguments; If changes are wanted,
you must get the grid object and update desired properties. You will need
to set the 'GridObject' property to the updated 'GridObject'.

Properties;
- CFrame (CFrame):        Determines the position and rotation of the grid
- CellSize (Vector3):     Determines the default size of the each cell
- Size (Vector3):         Determines the size of the grid
- Type (string):          Determines the grid type when populating
```

<h2>2: Create the Character object</h2>

```
The Character object is used to interact with core components of the character, 
including pathfinding. It contains properties that define how the character 
can traverse the grid when moving toward a destination.

Properties;
- CanClimb (boolean):        Determines if the character is allowed to climb.
- MaxClimbHeight (number):   The maximum vertical height the character can climb.
- MaxFallHeight (number):    The maximum vertical distance the character can fall.
- MaxMoveDistance (number):  The maximum number of path nodes the character can move in a single turn.
```
