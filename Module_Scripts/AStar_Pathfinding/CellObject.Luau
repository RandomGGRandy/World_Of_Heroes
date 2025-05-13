-- // Variables \\ --
-- // Math
local Abs = math.abs;
local sign = math.sign;

-- // Misc
local CellCost = {
	Walkable = 1,
	Climbable = 3,
	None = math.huge,

};


-- // Module \\ --
local Class, Metamethods = {}, {};
Metamethods.__index = Metamethods;
Metamethods.__eq = function(self: CellObject, b: CellObject): boolean
	if typeof(self) ~= "table" or typeof(b) ~= "table" then
		return false;
		
	end;
	
	return (self.Position == b.Position and self.Type == b.Type and self.Size == b.Size);
end;

-- // Metamethods
--[[Returns the cost of the given cell type
]]
function Metamethods.GetCost(self: CellObject, cellType: CellType): number
	return CellCost[cellType] or math.huge;
	
end;

--[[Returns the type of cell action is needed to move to this cell from the given cell
]]
function Metamethods.GetAction(self: CellObject, from: CellObject): CellAction
	
	-- Get the difference in height between the 2 cells
	local yDifference = self.Size.Y - from.Size.Y;
	local yDirection = sign(yDifference);
	
	-- Return the corrosponding action
	if (yDirection == 0) then -- Same height
		if (self.Type == "Walkable" or self.Type == "Climbable") then
			return "Walk";
			
		end;
	elseif (yDirection == 1) then -- Climbing up
		if (self.Type == "Climbable" and yDifference == 3) then
			return "Climb";
			
		end;
	elseif (yDirection == -1) then -- Dropping down
		if (yDifference < 9) then
			return "Jump";
			
		end;
	end;
	
	return "None";
end;

--[[Returns if the cell is traversable
]]
function Metamethods.IsTraversable(self: CellObject, from: CellObject): boolean
	
	local action = self:GetAction(from);
	return (self:GetAction(from) ~= "None" and not self.Occupant);
end;


-- // Class
--[[Create a new object
]]
function Class.New()

	local self = setmetatable({}, Metamethods);
	self.Occupant = nil;
	self.Position = Vector2.zero;
	self.WorldPosition = Vector3.zero;
	self.Size = Vector3.one;
	self.Type = "Walkable" :: CellType;
	
	self.Cost = {
		Walkable = 1,
		Climbable = 2,
		None = math.huge,
		
		
	} :: {[CellType]: number};
	
	return self;
end;

export type CellAction = "None" | "Climb" | "Jump" | "Walk";
export type CellLabel = "Crate" | "";
export type CellType = "Climbable" | "Walkable" | "None";
export type CellObject = typeof(Class.New()) & typeof(Metamethods);
return Class;
