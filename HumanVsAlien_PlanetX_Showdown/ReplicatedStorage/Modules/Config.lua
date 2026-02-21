--!strict
-- Centralized tuning values, IDs, and permissions.

local Config = {
	Game = {
		Title = "Human vs Alien — PlanetX Showdown",
		RoundDuration = 900,
		IntermissionDuration = 30,
		MinPlayers = 2,
	},

	DataStore = {
		Name = "PlanetXShowdown_v1",
		Scope = "global",
	},

	Currency = {
		KillReward = 25,
		FuelDeliveryReward = 40,
		ObjectiveReward = 100,
		SurvivalReward = 20,
		HumanRewardMultiplier = 1.15,
		AlienRewardMultiplier = 1.0,
	},

	DeathRay = {
		FuelPerCharge = 10,
		RequiredCharge = 100,
		ChargePerSecond = 1,
		DisableDurationFromEMP = 20,
		InstantActivationGamePassId = 0, -- TODO: insert GamePass ID
	},

	Research = {
		RequiredOperators = 2,
		SpeedBoostFromPresident = 1.25,
		BaseResearchRate = 1,
	},

	Leaders = {
		HumanLeaderGamePassId = 0, -- TODO: President pass
		AlienLeaderGamePassId = 0, -- TODO: Overmind pass
		LeaderVoteDuration = 15,
	},

	Admin = {
		Enabled = true,
		DebugLogging = true,
		UserIds = {12345678}, -- TODO: replace
	},

	RateLimits = {
		Ability = 0.15,
		ShopPurchase = 0.2,
		RoleSelect = 0.25,
		AdminCommand = 0.1,
	},

	Assets = {
		Animations = {
			Idle = 0,
			Run = 0,
			Attack = 0,
			Ability = 0,
		},
		Audio = {
			Lobby = 0,
			Combat = 0,
			DeathRayCharge = 0,
			EndingPeace = 0,
		},
	},

	External = {
		NexusDynamicsAssetId = 0, -- TODO: insert official model/package asset ID
	},
}

return Config
