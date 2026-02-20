--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local Config = require(ReplicatedStorage.Modules.Config)

local function loadAnimation(humanoid: Humanoid, animationId: number)
	if animationId == 0 then return nil end
	local anim = Instance.new("Animation")
	anim.AnimationId = "rbxassetid://" .. animationId
	return humanoid:LoadAnimation(anim)
end

Players.LocalPlayer.CharacterAdded:Connect(function(character)
	local humanoid = character:WaitForChild("Humanoid") :: Humanoid
	local idleTrack = loadAnimation(humanoid, Config.Assets.Animations.Idle)
	if idleTrack then idleTrack:Play() end
end)
