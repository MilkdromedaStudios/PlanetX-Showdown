--!strict
--[[
README MODULE - Human vs Alien — PlanetX Showdown

1) GamePass IDs
   - Set these in ReplicatedStorage/Modules/Config.lua:
     * DeathRay.InstantActivationGamePassId
     * Leaders.HumanLeaderGamePassId
     * Leaders.AlienLeaderGamePassId

2) DataStore
   - DataStore keys are configured by Config.DataStore.Name and Scope.
   - Saved fields: coins, wins, timesLeader, peaceEndingUnlocked.

3) Endings
   - Alien Vaporization: death ray reaches required charge and fires.
   - Human Military Victory: aliens eliminated OR death ray destroyed/disabled at end.
   - Secret Peace: timer expires, death ray not fired, both teams still have enough players,
     and optional leader agreement flag is true.

4) Balance tuning
   - Edit Config.Currency and Config.Research for economy and pacing.
   - Humans are intentionally slightly advantaged via multiplier and research scaling.

5) Lobby + map
   - A playable lobby and both faction bases are built automatically by MapBuilderService.
   - Replace runtime-generated geometry with handcrafted maps whenever ready.

6) Nexus Dynamics by dev equip
   - Insert official package/model under ReplicatedStorage and name it "NexusDynamics".
   - Fill Config.External.NexusDynamicsAssetId.
   - Extend NexusDynamicsService to call package APIs.

7) Asset replacement
   - Replace animation/audio placeholder IDs in Config.Assets.

8) Assembly
   - Place scripts in corresponding Roblox services matching folder names.
   - Ensure remotes in ReplicatedStorage/Remotes exist with matching names.
   - Start with ServerScriptService/Main.server.lua enabled.
]]

return true
