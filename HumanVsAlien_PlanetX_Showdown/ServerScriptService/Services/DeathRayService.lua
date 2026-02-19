--!strict
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Config = require(ReplicatedStorage.Modules.Config)
local Security = require(ReplicatedStorage.Modules.Security)

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local endingEvent = remotes:WaitForChild("EndingEvent") :: RemoteEvent

local DeathRayService = {}
DeathRayService.Charge = 0
DeathRayService.DisabledUntil = 0
DeathRayService.Fired = false

function DeathRayService.AddFuel(player: Player, amount: number)
	if not Security.ValidateTeam(player, "Aliens") then return end
	DeathRayService.Charge = math.clamp(DeathRayService.Charge + amount, 0, Config.DeathRay.RequiredCharge)
end

function DeathRayService.DisableByEMP(duration: number)
	DeathRayService.DisabledUntil = os.clock() + duration
end

function DeathRayService.Tick(dt: number)
	if DeathRayService.Fired then return end
	if os.clock() < DeathRayService.DisabledUntil then return end
	DeathRayService.Charge = math.clamp(DeathRayService.Charge + (Config.DeathRay.ChargePerSecond * dt), 0, Config.DeathRay.RequiredCharge)
	if DeathRayService.Charge >= Config.DeathRay.RequiredCharge then
		DeathRayService.Fire("Standard")
	end
end

function DeathRayService.TryInstantActivation(player: Player): boolean
	if not Security.ValidateTeam(player, "Aliens") then return false end
	local ok, owns = pcall(function()
		return MarketplaceService:UserOwnsGamePassAsync(player.UserId, Config.DeathRay.InstantActivationGamePassId)
	end)
	if ok and owns then
		DeathRayService.Charge = Config.DeathRay.RequiredCharge
		DeathRayService.Fire("Instant")
		return true
	end
	return false
end

function DeathRayService.Fire(mode: string)
	if DeathRayService.Fired then return end
	DeathRayService.Fired = true
	endingEvent:FireAllClients("AlienVaporization", {mode = mode})
end

return DeathRayService
