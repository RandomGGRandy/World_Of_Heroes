-- // Variables \\ --
local platformCFrame, platformSize = workspace.Platform.CFrame, workspace.Platform.Size;
local TargetCFrame = workspace.Target:GetPivot();

-- Creating the grid that will be used for all pathfinding logic
local pathfindingGrid = Pathfinding:CreateGrid(platformCFrame, platformSize, Vector3.one * 4);
pathfindingGrid.Type = Enums.GridType.Square;
pathfindingGrid:PopulateCells();

-- Re-assigning the grid after modifactions are made to the grid Object
Pathfinding.Grid = pathfindingGrid;

-- This method is used for testing pathfinding/obstacles
Pathfinding:SetRandomCellsType("Climbable", 275);

-- Creating the character object, which also binds a pathObject to the character
-- Also getting the binding pathObject
local CharacterObject = Character.New(workspace.Start); -- The character's model
local PathObject = CharacterObject:GetPathObject();

-- Optional binding for when the pathfinding has finished calculations
PathObject.Calculated:Connect(function(status: Enums.PathStatus)
  if (status == "Success") then
    
    -- Creates testing visuals for the calculated path after calculations
    PathObject:CreateVisuals();
  end;
end);

-- Calculate the character's path to the desired destination
CharacterObject:CalculatePath(TargetCFrame.Position);
