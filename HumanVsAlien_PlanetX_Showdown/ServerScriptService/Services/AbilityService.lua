--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Security = require(ReplicatedStorage.Modules.Security)
local Roles = require(ReplicatedStorage.Modules.RoleDefinitions)
local RolesService = require(script.Parent.RolesService)

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local abilityRemote = remotes:WaitForChild("AbilityRequest") :: RemoteEvent

local AbilityService = {}
local lastAbilityUse: {[Player]: number} = {}

abilityRemote.OnServerEvent:Connect(function(player, payload)
	if type(payload) ~= "table" then return end
	if not Security.RateLimit(player, "Ability") then return end
	local roleName = RolesService.GetRole(player)
	if not roleName then return end
	local roleData = Roles[roleName]
	if not roleData then return end
	local now = os.clock()
	if now - (lastAbilityUse[player] or 0) < roleData.Cooldown then
		return
	end
	lastAbilityUse[player] = now
	abilityRemote:FireClient(player, "AbilityConfirmed", roleName, payload)
end)

return AbilityService
