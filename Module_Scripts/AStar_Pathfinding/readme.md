<h2>1: Create the grid using 'CreateGrid'</h2>

```
The grid is initialized using the provided arguments during creation.
If you need to modify the grid after it's been created, access the
grid object directly, update the desired properties, and reassign it
via the `GridObject` property to apply the changes. After modifying
or replacing the grid, you must call `PopulateGrid()` to apply the
changes.

Properties;
- CFrame (CFrame):        Sets the origin position and orientation of the grid in world space.
- CellSize (Vector3):     Defines the size of each individual cell. Supports non-uniform sizes (e.g, 3x5x3).
- Size (Vector3):         Specifies the total size of grid in the X and Z directions.
- Type (string):          Defines the grid's population logic or structure (e.g., `Circle`, `Custom`, `Square`).

Methods;
- Creates the grid Object using the given parameters
Pathfinding:CreateGrid(location: CFrame, size: Vector3, cellSize: Vector3?): GridObject

- Populates the grid with cells, created by the pathfinding
GridObject:PopulateCells(): ()
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

<h2>3: Calculating and following the path</h2>

```
Pathfinding is initiated using the Character object. Once the character and grid are set up, 
you can calculate a path to a desired destination using the provided API. The path result 
can optionally be handled by connecting to a signal before calculation.

Methods;
- Calculates the path from the character to the given destination
CharacterObject:CalculatePath(destination: Vector3): ()

- Returns the character's binded path object
CharacterObject:GetPathObject():
```
