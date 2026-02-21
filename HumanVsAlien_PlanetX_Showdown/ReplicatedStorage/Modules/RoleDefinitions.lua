--!strict
-- Role table consumed by server-side role system.

export type RoleData = {
	Team: "Humans" | "Aliens",
	Passive: string,
	Active: string,
	Cooldown: number,
	StarterLoadout: {string},
}

local Roles: {[string]: RoleData} = {
	RocketScientist = {
		Team = "Humans",
		Passive = "Research speed +15% near consoles",
		Active = "Deploy Micro-Thruster Trap",
		Cooldown = 25,
		StarterLoadout = {"Pistol", "Wrench", "Blueprint"},
	},
	Engineer = {
		Team = "Humans",
		Passive = "Build speed +20%",
		Active = "Repair Burst",
		Cooldown = 20,
		StarterLoadout = {"SMG", "RepairTool", "BarricadeKit"},
	},
	Janitor = {
		Team = "Humans",
		Passive = "Cleans hazards for bonus coins",
		Active = "Foam Slow Field",
		Cooldown = 30,
		StarterLoadout = {"Shotgun", "FoamSprayer"},
	},
	Security = {
		Team = "Humans",
		Passive = "+15 max health",
		Active = "Tactical Shield",
		Cooldown = 35,
		StarterLoadout = {"Rifle", "Flashbang"},
	},
	Pilot = {
		Team = "Humans",
		Passive = "Movement speed +8%",
		Active = "Recon Drone Ping",
		Cooldown = 28,
		StarterLoadout = {"Carbine", "DroneController"},
	},
	Commander = {
		Team = "Aliens",
		Passive = "Nearby allies gain damage buff",
		Active = "Battle Roar",
		Cooldown = 32,
		StarterLoadout = {"PlasmaRifle", "Claw"},
	},
	Warrior = {
		Team = "Aliens",
		Passive = "Melee lifesteal",
		Active = "Lunge",
		Cooldown = 18,
		StarterLoadout = {"Claw", "Spines"},
	},
	Scout = {
		Team = "Aliens",
		Passive = "Stealth while crouched",
		Active = "Dash Cloak",
		Cooldown = 24,
		StarterLoadout = {"Needler", "Scanner"},
	},
	BioEngineer = {
		Team = "Aliens",
		Passive = "Fuel carry penalty reduced",
		Active = "Mutagen Field",
		Cooldown = 27,
		StarterLoadout = {"AcidSprayer", "Injector"},
	},
	Tech = {
		Team = "Aliens",
		Passive = "Death ray charge +10% efficiency",
		Active = "Overclock Node",
		Cooldown = 26,
		StarterLoadout = {"PulsePistol", "HackingProbe"},
	},
}

return Roles
