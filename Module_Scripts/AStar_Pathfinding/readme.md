<h2>1: Create the grid using 'CreateGrid'</h2>

```
The grid is initialized using the provided arguments during creation.
If you need to modify the grid after it's been created, access the
grid object directly, update the desired properties, and reassign it
via the `GridObject` property to apply the changes.

Properties;
- CFrame (CFrame):        Sets the origin position and orientation of the grid in world space.
- CellSize (Vector3):     Defines the size of each individual cell. Supports non-uniform sizes (e.g, 3x5x3).
- Size (Vector3):         Specifies the total size of grid in the X and Z directions.
- Type (string):          Defines the grid's population logic or structure (e.g., `Circle`, `Custom`, `Square`).
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
