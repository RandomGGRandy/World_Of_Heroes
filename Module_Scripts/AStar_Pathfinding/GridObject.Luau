--!strict
-- // Modules \\ --
local Cell = require("./Grid/Cell");

-- // Variables \\ --
local CardinalDirections = {
	Vector2.new(1, 0),   -- Right
	Vector2.new(-1, 0),  -- Left
	Vector2.new(0, 1),   -- Down
	Vector2.new(0, -1),  -- Up
	
};


-- // Module \\ --
local Class, Metamethods = {}, {};
Metamethods.__index = Metamethods;

-- // Metamethods \\ --
--[[Converts the given tile coordinates to world position
]]
function Metamethods.CellToWorld(self: GridObject, cellIndex: Vector2): Vector3

	-- Convert the cell indices to zero-based grid indices
	cellIndex -= Vector2.one;

	-- Get the size offsets for the platform and cell
	local pSizeOffset = self.Size / 2;
	local cSizeOffset = self.CellSize / 2;

	-- Convert the cell indices to a local position on the grid
	local x = pSizeOffset.X - (cellIndex.X * self.CellSize.X) - cSizeOffset.X;
	local z = pSizeOffset.Z - (cellIndex.Y * self.CellSize.Y) - cSizeOffset.Y;

	-- Convert local position to world space using platform's CFrame
	return self.CFrame:PointToWorldSpace(Vector3.new(x, 0, z));
end;

--[[Returns the cell at the given grid indices, or nil if out of bounds
]]
function Metamethods.GetCellAtIndex(self: GridObject, cellIndex: Vector2): CellObject?
	return if self.Cells[cellIndex.X] then self.Cells[cellIndex.X][cellIndex.Y] else nil;

end;

--[[Returns the cell at the given world position, or nil if out of bounds
]]
function Metamethods.GetCellAtWorldPosition(self: GridObject, worldpos: Vector3): CellObject?

	-- Convert the world position to cell index
	local cellIndex = self:WorldToCell(worldpos);

	-- Return the cell object at the given indices
	return self:GetCellAtIndex(cellIndex);
end;

--[[Returns a list of traversable neighboring cells from the current cell
]]
function Metamethods.GetNeighboringCells(self: GridObject, currentCell: CellObject): {CellObject}

	-- Create a table to store the neighboring cells
	local neighbors: {CellObject} = {};
	
	-- Shuffle the cardinal directions
	Random.new(tick()):Shuffle(CardinalDirections);
	
	-- Iterate through each cardinal direction
	for _, direction in CardinalDirections do

		-- Get the neighboring cell's position
		local cellPosition = currentCell.Position + direction;

		-- If the neighbor exists and can be traversed from the current cell
		local neighbor = self:GetCellAtIndex(cellPosition);
		if neighbor and neighbor:IsTraversable(currentCell) then
			table.insert(neighbors, neighbor);

		end;
	end;

	return neighbors;
end;

--[[Populates the grid cells
]]
function Metamethods.PopulateCells(self: GridObject)

	-- Get the cell count in each direction
	local countX = self.Size.X // self.CellSize.X;
	local countZ = self.Size.Z // self.CellSize.Y;

	-- Populate each cell in the grid
	for x = 1, countX do
		self.Cells[x] = {};

		for z = 1, countZ do

			-- Create a new cell object
			local cellObject = Cell.New();
			cellObject.Position = Vector2.new(x, z);
			cellObject.WorldPosition = self:CellToWorld(cellObject.Position);

			-- Set the value to the cell object
			self.Cells[x][z] = cellObject :: any;
		end;
	end;
end;

--[[Converts the given world position to cell coordinates
]]
function Metamethods.WorldToCell(self: GridObject, worldPosition: Vector3): Vector2

	-- Convert world position to local space relative to the platform
	local relative = self.CFrame:PointToObjectSpace(worldPosition);

	-- Convert local X and Z to zero-based grid indices, then make them 1-based
	local x = ((self.Size.X / 2 - relative.X) // self.CellSize.X) + 1;
	local z = ((self.Size.Z / 2 - relative.Z) // self.CellSize.Y) + 1;

	-- Return the cell coordinates
	return Vector2.new(x, z);	
end;



-- // Class \\ --
function Class.New()
	
	local self = setmetatable({}, Metamethods);
	
	-- Base properties
	self.CFrame = CFrame.identity;
	self.Size = Vector3.one;
	
	-- Cell properties
	self.Cells = {} :: {{CellObject}};
	self.CellSize = Vector2.one * 4;
	
	-- Signals
	self.PathCompleted = Instance.new("BindableEvent");
	
	return self;
end;

export type CellObject = Cell.CellObject;
export type GridObject = typeof(Class.New(...));
return Class;

