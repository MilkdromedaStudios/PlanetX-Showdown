--!strict
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(ReplicatedStorage.Modules.Config)
local Data = require(script.Parent.DataStoreService)

local LeaderService = {}
LeaderService.Current = {
	Humans = nil :: Player?,
	Aliens = nil :: Player?,
}

local function ownsPass(player: Player, passId: number): boolean
	if passId == 0 then return false end
	local ok, owns = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, passId)
	end)
	return ok and owns
end

local function pickLeader(teamName: string, passId: number): Player?
	local candidates = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Team and player.Team.Name == teamName and ownsPass(player, passId) then
			table.insert(candidates, player)
		end
	end
	return candidates[1]
end

function LeaderService.AssignLeaders()
	LeaderService.Current.Humans = pickLeader("Humans", Config.Leaders.HumanLeaderGamePassId)
	LeaderService.Current.Aliens = pickLeader("Aliens", Config.Leaders.AlienLeaderGamePassId)
	for _, leader in pairs(LeaderService.Current) do
		if leader then
			Data.Update(leader, "timesLeader", 1)
		end
	end
end

return LeaderService
