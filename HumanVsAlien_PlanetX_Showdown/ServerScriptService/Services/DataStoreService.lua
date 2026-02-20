--!strict
local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")

local Config = require(game.ReplicatedStorage.Modules.Config)

local store = DataStoreService:GetDataStore(Config.DataStore.Name, Config.DataStore.Scope)

local Data = {}
local cache: {[Player]: {[string]: any}} = {}

local defaults = {
	coins = 0,
	wins = 0,
	timesLeader = 0,
	peaceEndingUnlocked = false,
}

function Data.Load(player: Player)
	local key = tostring(player.UserId)
	local ok, result = pcall(function()
		return store:GetAsync(key)
	end)
	local profile = table.clone(defaults)
	if ok and type(result) == "table" then
		for k, v in pairs(result) do
			profile[k] = v
		end
	end
	cache[player] = profile
	return profile
end

function Data.Get(player: Player)
	return cache[player]
end

function Data.Update(player: Player, field: string, delta: number)
	local profile = cache[player]
	if not profile then return end
	profile[field] = (profile[field] or 0) + delta
end

function Data.Set(player: Player, field: string, value: any)
	local profile = cache[player]
	if not profile then return end
	profile[field] = value
end

function Data.Save(player: Player)
	local profile = cache[player]
	if not profile then return end
	local key = tostring(player.UserId)
	pcall(function()
		store:SetAsync(key, profile)
	end)
end

Players.PlayerRemoving:Connect(function(player)
	Data.Save(player)
	cache[player] = nil
end)

game:BindToClose(function()
	for _, player in ipairs(Players:GetPlayers()) do
		Data.Save(player)
	end
end)

return Data
