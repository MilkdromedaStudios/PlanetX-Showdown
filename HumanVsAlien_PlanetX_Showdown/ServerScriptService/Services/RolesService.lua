--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RoleDefinitions = require(ReplicatedStorage.Modules.RoleDefinitions)
local Security = require(ReplicatedStorage.Modules.Security)

local roleSelected = Instance.new("RemoteEvent")
roleSelected.Name = "RoleSelected"
roleSelected.Parent = ReplicatedStorage.Remotes

local RolesService = {}
local playerRoles: {[Player]: string} = {}

function RolesService.AssignRole(player: Player, roleName: string): boolean
	local role = RoleDefinitions[roleName]
	if not role then return false end
	if not Security.ValidateTeam(player, role.Team) then return false end
	playerRoles[player] = roleName
	return true
end

function RolesService.GetRole(player: Player): string?
	return playerRoles[player]
end

roleSelected.OnServerEvent:Connect(function(player, roleName)
	if type(roleName) ~= "string" then return end
	if not Security.RateLimit(player, "RoleSelect") then return end
	if RolesService.AssignRole(player, roleName) then
		roleSelected:FireClient(player, roleName, RoleDefinitions[roleName])
	end
end)

return RolesService
