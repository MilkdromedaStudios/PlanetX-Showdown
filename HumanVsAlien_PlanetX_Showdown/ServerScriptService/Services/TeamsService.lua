--!strict
local Teams = game:GetService("Teams")

local TeamsService = {}

function TeamsService.Init()
	for _, teamName in ipairs({"Humans", "Aliens", "Lobby"}) do
		if not Teams:FindFirstChild(teamName) then
			local team = Instance.new("Team")
			team.Name = teamName
			team.AutoAssignable = (teamName == "Lobby")
			if teamName == "Humans" then
				team.TeamColor = BrickColor.new("Bright blue")
			elseif teamName == "Aliens" then
				team.TeamColor = BrickColor.new("Bright red")
			else
				team.TeamColor = BrickColor.new("Medium stone grey")
			end
			team.Parent = Teams
		end
	end
end

return TeamsService
