-- // Modules \\ --
local Grid = require("./Pathfinding/Grid");
local Path = require("./Pathfinding/Path");


-- // Module \\ --
local Class, Metamethods = {}, {};
Metamethods.__index = Metamethods;

-- // Metamethods \\ --
--[[Creates a new grid for the pathfinding to use
]]
function Metamethods.CreateGrid(self: Pathfinding, location: CFrame, size: Vector2, cellsize: Vector2): PathfindingGrid
	
	-- Create a new grid
	local pathfindingGrid = Grid.New();
	pathfindingGrid.CFrame = location;
	pathfindingGrid.Size = size;
	pathfindingGrid.CellSize = cellsize;
	pathfindingGrid:PopulateCells();
	
	-- Returns the created grid object
	return pathfindingGrid;
end;

--[[Creates a new path using the given grid for pathfinding
]]
function Metamethods.CreatePath(self: Pathfinding, gridObject: PathfindingGrid, maxAttempts: number?): PathfindingPath
	
	-- Create a new path
	local PathfindingPath = Path.New();
	PathfindingPath.GridObject = gridObject;
	PathfindingPath.MaxAttempts = maxAttempts or 25;
	
	
	-- Returns the created path object
	return PathfindingPath;
end;

-- // Class \\ --
function Class.New()

	local self = setmetatable({}, Metamethods);

	return self;
end;

export type PathfindingGrid = Grid.GridObject;
export type PathfindingPath = Path.PathObject;
export type Pathfinding = typeof(Class.New());
return Class.New();
