--!strict
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(ReplicatedStorage.Modules.Config)
local Data = require(script.Parent.DataStoreService)
local DeathRay = require(script.Parent.DeathRayService)
local LeaderService = require(script.Parent.LeaderService)

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local hudUpdate = remotes:WaitForChild("HUDUpdate") :: RemoteEvent
local endingEvent = remotes:WaitForChild("EndingEvent") :: RemoteEvent

local GameState = {}
GameState.RoundActive = false
GameState.TimeLeft = Config.Game.RoundDuration
GameState.LeaderAgreementForPeace = false

local function aliveCount(teamName: string): number
	local count = 0
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Team and player.Team.Name == teamName then
			count += 1
		end
	end
	return count
end

function GameState.StartRound()
	GameState.RoundActive = true
	GameState.TimeLeft = Config.Game.RoundDuration
	GameState.LeaderAgreementForPeace = false
	DeathRay.Fired = false
	DeathRay.Charge = 0
	LeaderService.AssignLeaders()
end

function GameState.EndRound(reason: string)
	GameState.RoundActive = false
	endingEvent:FireAllClients(reason)
	if reason == "SecretPeace" then
		for _, player in ipairs(Players:GetPlayers()) do
			Data.Update(player, "coins", 300)
			Data.Set(player, "peaceEndingUnlocked", true)
		end
	end
end

function GameState.EvaluateWinConditions()
	if DeathRay.Fired then
		GameState.EndRound("AlienVaporization")
		return
	end
	if aliveCount("Humans") == 0 then
		GameState.EndRound("AlienVictory")
		return
	end
	if aliveCount("Aliens") == 0 then
		GameState.EndRound("HumanMilitaryVictory")
		return
	end
	if GameState.TimeLeft <= 0 then
		if aliveCount("Humans") >= 1 and aliveCount("Aliens") >= 1 and GameState.LeaderAgreementForPeace then
			GameState.EndRound("SecretPeace")
		else
			GameState.EndRound("HumanMilitaryVictory")
		end
	end
end

RunService.Heartbeat:Connect(function(dt)
	if not GameState.RoundActive then return end
	GameState.TimeLeft -= dt
	DeathRay.Tick(dt)
	GameState.EvaluateWinConditions()
	hudUpdate:FireAllClients({
		timeLeft = GameState.TimeLeft,
		deathRayCharge = DeathRay.Charge,
		leaders = LeaderService.Current,
	})
end)

return GameState
