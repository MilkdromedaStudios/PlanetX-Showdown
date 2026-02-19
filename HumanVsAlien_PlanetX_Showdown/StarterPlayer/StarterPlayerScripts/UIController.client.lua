--!strict
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local remotes = ReplicatedStorage:WaitForChild("Remotes")

local hudUpdate = remotes:WaitForChild("HUDUpdate") :: RemoteEvent
local endingEvent = remotes:WaitForChild("EndingEvent") :: RemoteEvent

local screenGui = playerGui:WaitForChild("RetrowaveHUD") :: ScreenGui
local root = screenGui:WaitForChild("Root") :: Frame
local statusLabel = root:WaitForChild("Status") :: TextLabel

local function animatePulse(label: TextLabel)
	local tween = TweenService:Create(label, TweenInfo.new(0.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 1, true), {
		TextTransparency = 0.15,
	})
	tween:Play()
end

hudUpdate.OnClientEvent:Connect(function(payload)
	statusLabel.Text = string.format("TIME %.0f | RAY %.0f%%", payload.timeLeft, payload.deathRayCharge)
	animatePulse(statusLabel)
end)

endingEvent.OnClientEvent:Connect(function(endingName)
	statusLabel.Text = "ENDING: " .. tostring(endingName)
end)
