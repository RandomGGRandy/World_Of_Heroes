-- // Modules \\ --
local Grid = require("./Grid");
local Utils = require("./Utils");

-- // Functions \\ --
--[[Returns the cell with the lowest F score
]]
function GetLowestFScore(set: {CellObject}, score: {[CellObject]: number})

	-- Preset the lowest values
	local lowestCell = set[1];
	local lowestScore = score[lowestCell] or math.huge;

	-- Iterate through each cell from the set
	for _, cell in set do

		-- Get the score or default to inf
		local currentScore = score[cell] or math.huge;
		if (currentScore < lowestScore) then

			-- Update the lowest cell and score
			lowestCell, lowestScore = cell, currentScore;
		end;
	end;

	-- Return the lowest cell
	return lowestCell;
end;

--[[Reconstruct the table of waypoints from goal to start
]]
function ReconstructWaypoints(steps: {[CellObject]: CellObject}, currCell: CellObject): {PathWaypoint}

	-- Create a table to store the reconcostructed waypoints
	local waypoints = {};

	-- Loop until there is no longer a current cell
	while steps[currCell] do
		task.wait();

		-- Get the previous cell object
		local prevCell: CellObject = steps[currCell];

		-- Index the new waypoint
		local waypointAction = currCell:GetWaypointAction(prevCell);
		table.insert(waypoints, 1, PathWaypoint.new(currCell.WorldPosition, waypointAction));

		-- Update the current cell object
		currCell = prevCell;
	end;

	return waypoints;
end;

--[[Returns the Manhattan distance between two cell positions
]]
function GetManhattanDistance(a: Vector2, b: Vector2)

	-- Calculate the absoluate distance
	local vector = (a - b):Abs();

	-- Return the vector distance
	return vector.X + vector.Y;
end;


-- // Module \\ --
local Class, Metamethods = {}, {};
Metamethods.__index = Metamethods;

-- // Metamethods \\ --
--[[Calculates the path from the given start and target position
]]
function Metamethods.CalculatePath(self: PathObject, startPos: Vector3, targetPos: Vector3)
	
	-- Function to update the path status and waypoints
	local function updatePath(status: PathStatus, waypoints: {PathWaypoint})
		if (self.Status ~= status) then
			
			-- Update the path's status and waypoints
			self.Status = status;
			self.Waypoints = waypoints;
		end;
	end;
	
	-- Throw a warning if the grid is missing
	local success = Utils.Assert(self.GridObject, "PathObject's grid is missing", Enum.MessageType.MessageWarning);
	if (not success) then return end;
	
	-- Retrieve the corresponding cells
	local start = self.GridObject:GetCellAtWorldPosition(startPos)
	local target = self.GridObject:GetCellAtWorldPosition(targetPos);

	-- Throw a warning if the starting or the target cell is missing
	local success = Utils.Assert(start and target, "Starting/Target cell is missing", Enum.MessageType.MessageWarning);
	if (not success) then return end;
	
	-- Update the path
	updatePath("Idle", {});
	
	-- A* pathfinding setup
	local set = {start};
	local steps = {};
	local gScore = {[start] = 0};
	local fScore = {[start] = GetManhattanDistance(start.Position, target.Position)};
	
	-- Create the thread that calculates a possible path
	local thread = coroutine.create(function(callback: (status: PathStatus, waypoints: {PathWaypoint}) -> ())
		for attempt = 1, self.MaxAttempts do

			-- Loop if the set is not empty
			while (#set > 0) do

				-- Get the cell with the lowest fScore from the set
				local current = GetLowestFScore(set, fScore);
				if (current == target) then

					-- Path found successfully, reconstruct waypoints and exit
					callback("Success", ReconstructWaypoints(steps, current));
					return;
				end;

				-- Remove the current cell from the set
				table.remove(set, table.find(set, current));

				-- Iterate through each neighboring cell
				for _, neighbor in self.GridObject:GetNeighboringCells(current) do

					-- Get the gScore values
					local cScore = gScore[current] or math.huge;
					local nScore = gScore[neighbor] or math.huge;

					-- If a better path with a lower cost is found
					local cost = cScore + current:GetCost(neighbor.Type);
					if (cost < nScore) then

						-- Index the next cell set
						steps[neighbor] = current;

						-- Update the cell's score
						gScore[neighbor] = cost;
						fScore[neighbor] = cost + GetManhattanDistance(neighbor.Position, target.Position);

						-- If the next cell doesn't exist within the set, add it
						if (not table.find(set, neighbor)) then
							table.insert(set, neighbor);

						end;
					end;
				end;
			end;
		end;

		-- If no path was found after max attempts, return "NoPath
		callback("NoPath", {});
		return;
	end);

	-- Resume the coroutine
	coroutine.resume(thread, function(status: PathStatus, waypoints: {PathWaypoint})

		-- Update the path
		updatePath(status, waypoints);

		-- Fire the finished event
		self.Finished:Fire();
	end);
end;

--[[Returns the path's current waypoints if any
]]
function Metamethods.GetWaypoints(self: PathObject): {PathWaypoint}
	return self.Waypoints;
	
end;


-- // Class \\ --
function Class.New()

	local self = setmetatable({}, Metamethods);
	self.GridObject = nil :: Grid.GridObject?;
	self.MaxAttempts = 25;
	self.Status = "Idle" :: PathStatus;
	self.Waypoints = {} :: {PathWaypoint};
	
	-- // Events
	self.Blocked = Instance.new("BindableEvent");
	self.Finished = Instance.new("BindableEvent");
	
	return self;
end;

export type PathStatus = "Idle" | "NoPath" | "Success";
export type PathObject = typeof(Class.New());
return Class;
