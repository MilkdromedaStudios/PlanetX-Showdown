--!strict
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local RemotesService = {}

function RemotesService.Init()
	local remotesFolder = ReplicatedStorage:FindFirstChild("Remotes")
	if not remotesFolder then
		remotesFolder = Instance.new("Folder")
		remotesFolder.Name = "Remotes"
		remotesFolder.Parent = ReplicatedStorage
	end

	for _, remoteName in ipairs({
		"RoleSelected",
		"AbilityRequest",
		"ShopPurchase",
		"ObjectiveUpdate",
		"LeaderCommand",
		"AdminCommand",
		"HUDUpdate",
		"EndingEvent",
	}) do
		if not remotesFolder:FindFirstChild(remoteName) then
			local remote = Instance.new("RemoteEvent")
			remote.Name = remoteName
			remote.Parent = remotesFolder
		end
	end
end

return RemotesService
