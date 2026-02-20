# HumanVsAlien_PlanetX_Showdown

This project now includes a generated Roblox XML place file:

- `HumanVsAlien_PlanetX_Showdown/HumanVsAlien_PlanetX_Showdown.rbxlx`

## Auto-update workflow for the `.rbxlx`
Whenever you edit any Lua source in this repo, regenerate the place file with:

```bash
python tools/generate_rbxlx.py
```

The generator embeds:
- `ReplicatedStorage/Modules/*.lua`
- `ServerScriptService/Main.server.lua`
- `ServerScriptService/Services/*.lua`
- `StarterGui/RetrowaveHUD/Init.client.lua`
- `StarterPlayer/StarterPlayerScripts/*.lua`
- `README.md` into a Docs StringValue
- `Workspace/MapPlaceholders/NOTES.txt`

## Why the file is large
The generated `.rbxlx` includes `Workspace/MapPlaceholders/HyperwaveDesignNodes` with many planning nodes so the place is substantial and easy to edit in Studio.

## Uploading to GitHub
If you are web-only, use **Add file → Upload files** on GitHub and upload this folder contents, including the `.rbxlx`.
