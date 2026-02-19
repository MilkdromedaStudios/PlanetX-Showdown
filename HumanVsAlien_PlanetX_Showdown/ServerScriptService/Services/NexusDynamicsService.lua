--!strict
-- Integration bridge for external Nexus Dynamics framework by dev equip.
-- This keeps the place runnable even before the package is inserted.

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Config = require(ReplicatedStorage.Modules.Config)

local NexusDynamicsService = {}
NexusDynamicsService.IsLoaded = false

function NexusDynamicsService.Init()
	local packageContainer = ReplicatedStorage:FindFirstChild("NexusDynamics")
	if packageContainer then
		NexusDynamicsService.IsLoaded = true
		print("[NexusDynamicsService] Nexus Dynamics detected and linked.")
	else
		warn("[NexusDynamicsService] Nexus Dynamics package not found. Insert package/model then rename to ReplicatedStorage/NexusDynamics.")
	end
end

function NexusDynamicsService.GetExpectedAssetId(): number
	return Config.External.NexusDynamicsAssetId
end

return NexusDynamicsService
