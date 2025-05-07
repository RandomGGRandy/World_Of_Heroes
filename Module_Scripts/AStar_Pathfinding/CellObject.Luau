-- // Variables \\ --
-- // Math
local Abs = math.abs;

-- // Misc
local CellCost = {
	Walkable = 1,
	Climbable = 2,
	None = math.huge,

};


-- // Module \\ --
local Class, Metamethods = {}, {};
Metamethods.__index = Metamethods;
Metamethods.__eq = function(self: CellObject, b: CellObject): boolean
	if typeof(self) ~= "table" or typeof(b) ~= "table" then
		return false;
		
	end;
	
	return (self.Position == b.Position and self.Type == b.Type and self.Height == b.Height);
end;

-- // Metamethods
--[[Returns the cost of the given cell type
]]
function Metamethods.GetCost(self: CellObject, cellType: CellType): number
	return CellCost[cellType] or math.huge;
	
end;

--[[Returns the type of waypoint action is needed to move to this cell from the given cell
]]
function Metamethods.GetWaypointAction(self: CellObject, from: CellObject)
	
	-- Get the difference in height between the 2 cells
	local heightDiff = Abs(self.Height - from.Height);
	
	-- Return the corrosponding waypoint action
	if (self.Type == "Climbable" and Abs(self.Height - from.Height)) then
		return Enum.PathWaypointAction.Jump;
		
	elseif (self.Type == "Walkable") then
		return Enum.PathWaypointAction.Walk;
	
	end
	
	return Enum.PathWaypointAction.Custom;
end;

--[[Returns if the cell is traversable
]]
function Metamethods.IsTraversable(self: CellObject, from: CellObject): boolean
	return (self:GetWaypointAction(from) ~= Enum.PathWaypointAction.Custom);
	
end;


-- // Class
--[[Create a new object
]]
function Class.New()

	local self = setmetatable({}, Metamethods);
	self.Occupant = nil;
	self.Height = 0;
	self.Position = Vector2.zero;
	self.WorldPosition = Vector3.zero;
	self.Type = "Walkable" :: CellType;
	
	self.Cost = {
		Walkable = 1,
		Climbable = 2,
		None = math.huge,
		
		
	} :: {[CellType]: number};
	
	return self;
end;

export type CellType = "Climbable" | "Walkable" | "None";
export type CellObject = typeof(Class.New()) & typeof(Metamethods);
return Class;
