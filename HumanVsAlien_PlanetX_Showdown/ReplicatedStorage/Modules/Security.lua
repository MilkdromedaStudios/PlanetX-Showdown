--!strict
local Players = game:GetService("Players")
local Config = require(script.Parent.Config)

local Security = {}
local lastCall: {[Player]: {[string]: number}} = {}

function Security.IsAdmin(player: Player): boolean
	for _, id in ipairs(Config.Admin.UserIds) do
		if id == player.UserId then
			return true
		end
	end
	return false
end

function Security.RateLimit(player: Player, key: string, interval: number?): boolean
	local now = os.clock()
	lastCall[player] = lastCall[player] or {}
	local previous = lastCall[player][key] or 0
	local required = interval or Config.RateLimits[key] or 0.2
	if now - previous < required then
		return false
	end
	lastCall[player][key] = now
	return true
end

function Security.ValidateTeam(player: Player, teamName: string): boolean
	return player.Team ~= nil and player.Team.Name == teamName
end

Players.PlayerRemoving:Connect(function(player)
	lastCall[player] = nil
end)

return Security
