--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Security = require(ReplicatedStorage.Modules.Security)
local Data = require(script.Parent.DataStoreService)

local remotes = ReplicatedStorage:WaitForChild("Remotes")
local purchaseRemote = remotes:WaitForChild("ShopPurchase") :: RemoteEvent

local catalog = {
	Weapons = {
		PulseRifle = 300,
		RailSMG = 250,
	},
	Buffs = {
		FastReload = 200,
		ExtraArmor = 220,
	},
	Cosmetics = {
		NeonVisor = 150,
		RetroTrail = 180,
	},
}

local ShopService = {}

function ShopService.Purchase(player: Player, category: string, itemName: string): boolean
	local price = catalog[category] and catalog[category][itemName]
	if type(price) ~= "number" then return false end
	local profile = Data.Get(player)
	if not profile then return false end
	if profile.coins < price then return false end
	Data.Update(player, "coins", -price)
	return true
end

purchaseRemote.OnServerEvent:Connect(function(player, category, itemName)
	if type(category) ~= "string" or type(itemName) ~= "string" then return end
	if not Security.RateLimit(player, "ShopPurchase") then return end
	local success = ShopService.Purchase(player, category, itemName)
	purchaseRemote:FireClient(player, success, category, itemName)
end)

return ShopService
