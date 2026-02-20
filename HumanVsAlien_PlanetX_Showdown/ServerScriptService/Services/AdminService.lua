--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(ReplicatedStorage.Modules.Config)
local Security = require(ReplicatedStorage.Modules.Security)
local GameState = require(script.Parent.GameStateService)
local DeathRay = require(script.Parent.DeathRayService)
local Data = require(script.Parent.DataStoreService)

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local adminRemote = remotes:WaitForChild("AdminCommand") :: RemoteEvent

local AdminService = {}

local function log(...)
	if Config.Admin.DebugLogging then
		print("[AdminService]", ...)
	end
end

adminRemote.OnServerEvent:Connect(function(player, command, arg1, arg2)
	if not Config.Admin.Enabled then return end
	if not Security.IsAdmin(player) then return end
	if not Security.RateLimit(player, "AdminCommand") then return end
	if command == "start_round" then
		GameState.StartRound()
	elseif command == "end_round" then
		GameState.EndRound("AdminEnded")
	elseif command == "give_coins" and typeof(arg1) == "Instance" and arg1:IsA("Player") and type(arg2) == "number" then
		Data.Update(arg1, "coins", arg2)
	elseif command == "fill_death_ray" then
		DeathRay.Charge = Config.DeathRay.RequiredCharge
	elseif command == "spawn_fuel" then
		log("Spawn fuel requested by", player.Name)
	end
	log("Executed", command, player.Name)
end)

return AdminService
