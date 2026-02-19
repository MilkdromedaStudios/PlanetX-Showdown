--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(ReplicatedStorage.Modules.Config)
local Security = require(ReplicatedStorage.Modules.Security)
local DeathRay = require(script.Parent.DeathRayService)

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local objectiveUpdate = remotes:WaitForChild("ObjectiveUpdate") :: RemoteEvent

local ResearchService = {}
ResearchService.Progress = 0
ResearchService.EMPReady = false

function ResearchService.Contribute(player: Player, stationId: string)
	if not Security.ValidateTeam(player, "Humans") then return end
	if stationId ~= "RocketConsole" then return end
	ResearchService.Progress += Config.Research.BaseResearchRate
	if ResearchService.Progress >= 100 then
		ResearchService.EMPReady = true
	end
	objectiveUpdate:FireAllClients("Research", ResearchService.Progress)
end

function ResearchService.TriggerEMP(player: Player)
	if not Security.ValidateTeam(player, "Humans") then return false end
	if not ResearchService.EMPReady then return false end
	ResearchService.EMPReady = false
	ResearchService.Progress = 0
	DeathRay.DisableByEMP(Config.DeathRay.DisableDurationFromEMP)
	objectiveUpdate:FireAllClients("EMP", "Triggered")
	return true
end

return ResearchService
