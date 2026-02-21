--!strict
-- Builds playable placeholder geometry and spawns directly in Studio Play mode.

local Workspace = game:GetService("Workspace")

local MapBuilderService = {}

local function createPart(name: string, size: Vector3, cframe: CFrame, color: Color3, parent: Instance): Part
	local part = Instance.new("Part")
	part.Name = name
	part.Size = size
	part.CFrame = cframe
	part.Color = color
	part.Anchored = true
	part.TopSurface = Enum.SurfaceType.Smooth
	part.BottomSurface = Enum.SurfaceType.Smooth
	part.Parent = parent
	return part
end

local function createSpawn(name: string, cframe: CFrame, color: BrickColor, teamColor: BrickColor, parent: Instance): SpawnLocation
	local spawn = Instance.new("SpawnLocation")
	spawn.Name = name
	spawn.CFrame = cframe
	spawn.Size = Vector3.new(8, 1, 8)
	spawn.Anchored = true
	spawn.Neutral = false
	spawn.BrickColor = color
	spawn.TeamColor = teamColor
	spawn.Parent = parent
	return spawn
end

function MapBuilderService.Build()
	if Workspace:FindFirstChild("PlanetXMap") then
		return
	end

	local root = Instance.new("Folder")
	root.Name = "PlanetXMap"
	root.Parent = Workspace

	-- Lobby safe zone
	local lobby = Instance.new("Model")
	lobby.Name = "Lobby"
	lobby.Parent = root
	createPart("LobbyFloor", Vector3.new(120, 2, 120), CFrame.new(0, 0, 0), Color3.fromRGB(45, 25, 65), lobby)
	createPart("LobbyBarrierNorth", Vector3.new(120, 12, 2), CFrame.new(0, 6, -60), Color3.fromRGB(130, 50, 200), lobby)
	createPart("LobbyBarrierSouth", Vector3.new(120, 12, 2), CFrame.new(0, 6, 60), Color3.fromRGB(130, 50, 200), lobby)
	createPart("RoleKiosk", Vector3.new(18, 8, 8), CFrame.new(-25, 4, 0), Color3.fromRGB(0, 255, 255), lobby)
	createPart("ShopKiosk", Vector3.new(18, 8, 8), CFrame.new(25, 4, 0), Color3.fromRGB(255, 0, 140), lobby)
	createSpawn("LobbySpawn", CFrame.new(0, 3, 0), BrickColor.new("Royal purple"), BrickColor.new("Medium stone grey"), lobby)

	-- Earth human base
	local earth = Instance.new("Model")
	earth.Name = "EarthBase"
	earth.Parent = root
	createPart("EarthFloor", Vector3.new(160, 2, 110), CFrame.new(-220, 0, 0), Color3.fromRGB(55, 100, 135), earth)
	createPart("ResearchLab", Vector3.new(30, 20, 26), CFrame.new(-245, 10, -20), Color3.fromRGB(220, 235, 255), earth)
	createPart("RocketPad", Vector3.new(36, 2, 36), CFrame.new(-185, 1, 24), Color3.fromRGB(150, 150, 150), earth)
	createPart("EMPConsoleCluster", Vector3.new(20, 6, 12), CFrame.new(-250, 3, 25), Color3.fromRGB(0, 255, 255), earth)
	createSpawn("HumanSpawn", CFrame.new(-220, 3, 0), BrickColor.new("Bright blue"), BrickColor.new("Bright blue"), earth)

	-- PlanetX alien base
	local planetX = Instance.new("Model")
	planetX.Name = "PlanetX"
	planetX.Parent = root
	createPart("PlanetXFloor", Vector3.new(170, 2, 120), CFrame.new(230, 0, 0), Color3.fromRGB(70, 20, 20), planetX)
	createPart("DeathRayStructure", Vector3.new(36, 28, 36), CFrame.new(255, 14, -5), Color3.fromRGB(255, 65, 65), planetX)
	createPart("AlienArmory", Vector3.new(28, 14, 24), CFrame.new(195, 7, 22), Color3.fromRGB(120, 40, 60), planetX)
	createSpawn("AlienSpawn", CFrame.new(230, 3, 0), BrickColor.new("Bright red"), BrickColor.new("Bright red"), planetX)

	-- Fuel nodes for both teams/objectives
	local fuel = Instance.new("Folder")
	fuel.Name = "FuelNodes"
	fuel.Parent = root
	for index, x in ipairs({-190, -160, 170, 205}) do
		createPart(string.format("FuelNode_%d", index), Vector3.new(4, 4, 4), CFrame.new(x, 3, 45), Color3.fromRGB(255, 225, 0), fuel)
	end
end

return MapBuilderService
