--!strict
-- Entry point for HumanVsAlien_PlanetX_Showdown

local Players = game:GetService("Players")
local Teams = game:GetService("Teams")

local RemotesService = require(script.Services.RemotesService)
local TeamsService = require(script.Services.TeamsService)
local Data = require(script.Services.DataStoreService)
local GameState = require(script.Services.GameStateService)
local MapBuilder = require(script.Services.MapBuilderService)
local NexusDynamics = require(script.Services.NexusDynamicsService)

RemotesService.Init()
TeamsService.Init()
MapBuilder.Build()
NexusDynamics.Init()

local assignFlip = false

Players.PlayerAdded:Connect(function(player)
	local profile = Data.Load(player)
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player

	local coins = Instance.new("IntValue")
	coins.Name = "Coins"
	coins.Value = profile.coins
	coins.Parent = leaderstats

	player.Team = Teams:FindFirstChild("Lobby")
	task.delay(8, function()
		if not player.Parent then return end
		assignFlip = not assignFlip
		player.Team = assignFlip and Teams:FindFirstChild("Humans") or Teams:FindFirstChild("Aliens")
		player:LoadCharacter()
	end)
end)

task.wait(5)
GameState.StartRound()
