--!strict
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "RetrowaveHUD"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local root = Instance.new("Frame")
root.Name = "Root"
root.Size = UDim2.fromScale(1, 1)
root.BackgroundColor3 = Color3.fromRGB(10, 6, 24)
root.BorderSizePixel = 0
root.Parent = gui

local grid = Instance.new("UIGradient")
grid.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 140)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 255, 255)),
})
grid.Rotation = 45
grid.Parent = root

local status = Instance.new("TextLabel")
status.Name = "Status"
status.Size = UDim2.fromOffset(500, 50)
status.Position = UDim2.fromOffset(20, 20)
status.BackgroundTransparency = 0.35
status.BackgroundColor3 = Color3.fromRGB(30, 10, 50)
status.TextColor3 = Color3.fromRGB(100, 255, 255)
status.Font = Enum.Font.GothamBold
status.TextScaled = true
status.Text = "LOADING PLANETX SHOWDOWN..."
status.Parent = root
