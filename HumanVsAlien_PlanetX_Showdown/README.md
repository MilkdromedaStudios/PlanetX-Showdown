# HumanVsAlien_PlanetX_Showdown

A full Roblox game project featuring dynamic map generation, multi‑team gameplay, persistent progression, and a complete source layout. This repository now supports both **source‑based development** and an optional **auto‑generated `.rbxlx` place file** workflow.

---

# 📦 Project Structure (Source Layout)

This repository provides a full place **source hierarchy**. Scripts and modules are organized to match Roblox services:

### **Folder → Roblox Service Mapping**
- `ServerScriptService/*` → Server game systems (authoritative logic)
- `ReplicatedStorage/Modules/*` → Shared config and definition modules
- `ReplicatedStorage/Remotes` → Remote events (auto‑created by `RemotesService`)
- `StarterPlayer/StarterPlayerScripts/*` → HUD and animation controllers
- `StarterGui/RetrowaveHUD/*` → Retrowave UI bootstrap
- `Workspace/MapPlaceholders/*` → Optional manual map notes and geometry placeholders

---

# 🧠 Implemented Game Systems

- Round loop and endings (Alien Vaporization, Human Military, Secret Peace)
- Team and role framework with passives, actives, cooldowns, and loadouts
- Death Ray objective with EMP disable and instant activation GamePass validation
- Persistent economy (coins, wins, time leader, peace unlock)
- Shop purchases validated on server
- Leadership framework (President / Overmind) with pass checks
- Admin command pipeline with allow‑list UserIds and rate limiting
- Security layer for rate‑limits and trust boundaries
- Runtime map generation for lobby, spawns, fuel nodes, and objective structures
- Nexus Dynamics integration bridge (`NexusDynamicsService`) with placeholder asset ID

---

# 🛰 Nexus Dynamics (Developer Integration)

To fully enable the Nexus Dynamics package:

1. Insert the official Nexus Dynamics model/package into `ReplicatedStorage`.
2. Rename it to `NexusDynamics`.
3. Set `Config.External.NexusDynamicsAssetId`.
4. If the package exports APIs, bind them inside `NexusDynamicsService`.

---

# 🏗 Assembly Steps in Roblox Studio

1. Create a new place named **HumanVsAlien_PlanetX_Showdown**.
2. Recreate the folder/file structure in the corresponding Roblox services.
3. Paste script contents from this repository.
4. Replace all placeholder IDs in `Config.lua`.
5. Configure DataStore name/scope and admin UserIds.
6. Press **Play** to auto‑build the map and start the round flow.

---

# ⚖️ Balance Tuning

All balance values are centralized in:

