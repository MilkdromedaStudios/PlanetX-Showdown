from pathlib import Path
from xml.sax.saxutils import escape

ROOT = Path('HumanVsAlien_PlanetX_Showdown')
OUT = ROOT / 'HumanVsAlien_PlanetX_Showdown.rbxlx'

ref_id = 1

def next_ref():
    global ref_id
    r = f'RBX{ref_id}'
    ref_id += 1
    return r


def I(level: int) -> str:
    return '  ' * level


lines: list[str] = []


def add(s: str = ''):
    lines.append(s)


def begin_item(cls: str, level: int, name: str | None = None, extra_props: list[str] | None = None) -> str:
    ref = next_ref()
    add(f"{I(level)}<Item class=\"{cls}\" referent=\"{ref}\">")
    add(f"{I(level+1)}<Properties>")
    add(f"{I(level+2)}<bool name=\"Archivable\">true</bool>")
    if name is not None:
        add(f"{I(level+2)}<string name=\"Name\">{escape(name)}</string>")
    if extra_props:
        for p in extra_props:
            add(f"{I(level+2)}{p}")
    return ref


def end_item(level: int):
    add(f"{I(level+1)}</Properties>")
    add(f"{I(level)}</Item>")


def v3_prop(name: str, x: float, y: float, z: float) -> str:
    return f"<Vector3 name=\"{name}\"><X>{x}</X><Y>{y}</Y><Z>{z}</Z></Vector3>"


def cframe_prop(name: str, x: float, y: float, z: float) -> str:
    return (
        f"<CoordinateFrame name=\"{name}\">"
        f"<X>{x}</X><Y>{y}</Y><Z>{z}</Z>"
        "<R00>1</R00><R01>0</R01><R02>0</R02>"
        "<R10>0</R10><R11>1</R11><R12>0</R12>"
        "<R20>0</R20><R21>0</R21><R22>1</R22>"
        "</CoordinateFrame>"
    )


def color_prop(r: int, g: int, b: int) -> list[str]:
    return [
        f"<Color3uint8 name=\"Color\">{r}, {g}, {b}</Color3uint8>",
        "<bool name=\"UsePartColor\">true</bool>",
    ]


def part(level: int, name: str, size: tuple[float, float, float], pos: tuple[float, float, float], rgb=(163, 162, 165), material='Plastic', shape='Block'):
    props = [
        "<bool name=\"Anchored\">true</bool>",
        "<bool name=\"CanCollide\">true</bool>",
        "<bool name=\"Locked\">false</bool>",
        f"<token name=\"Material\">{ {'Plastic':256,'Neon':288,'Metal':1088,'Concrete':816,'Grass':512}.get(material,256) }</token>",
        f"<token name=\"shape\">{ {'Ball':1,'Cylinder':2,'Block':0}.get(shape,0) }</token>",
        v3_prop('Size', *size),
        cframe_prop('CFrame', *pos),
        *color_prop(*rgb),
    ]
    begin_item('Part', level, name, props)
    end_item(level)


def spawn(level: int, name: str, pos: tuple[float, float, float], team_color='Bright blue'):
    props = [
        "<bool name=\"Anchored\">true</bool>",
        "<bool name=\"CanCollide\">true</bool>",
        v3_prop('Size', 6, 1, 6),
        cframe_prop('CFrame', *pos),
        "<bool name=\"Neutral\">false</bool>",
        f"<string name=\"TeamColor\">{team_color}</string>",
    ]
    begin_item('SpawnLocation', level, name, props)
    end_item(level)


def script_with_source(level: int, cls: str, name: str, source: str):
    begin_item(cls, level, name)
    add(f"{I(level+2)}<ProtectedString name=\"Source\"><![CDATA[{source}]]></ProtectedString>")
    add(f"{I(level+2)}<bool name=\"Disabled\">false</bool>")
    end_item(level)


def string_value(level: int, name: str, value: str):
    begin_item('StringValue', level, name)
    add(f"{I(level+2)}<string name=\"Value\">{escape(value)}</string>")
    end_item(level)


add('<?xml version="1.0" encoding="utf-8"?>')
add('<roblox version="4">')
add('  <External>null</External>')
add('  <External>nil</External>')

# DataModel root
begin_item('DataModel', 1, 'HumanVsAlien_PlanetX_Showdown')

# Workspace with real map geometry
begin_item('Workspace', 2, 'Workspace')
part(3, 'Baseplate', (2048, 20, 2048), (0, -10, 0), rgb=(45, 49, 66), material='Concrete')

begin_item('Model', 3, 'PlanetSystem')
part(4, 'Earth', (240, 240, 240), (-900, 260, -220), rgb=(65, 140, 255), material='Neon', shape='Ball')
part(4, 'Moon', (90, 90, 90), (-660, 300, -120), rgb=(201, 201, 201), material='Metal', shape='Ball')
part(4, 'PlanetX', (320, 320, 320), (980, 280, 210), rgb=(255, 68, 93), material='Neon', shape='Ball')
part(4, 'SunBackdrop', (520, 520, 520), (0, 580, -1400), rgb=(255, 170, 0), material='Neon', shape='Ball')
end_item(3)

begin_item('Model', 3, 'EarthBase')
part(4, 'EarthGround', (560, 8, 460), (-420, 4, 0), rgb=(76, 115, 145), material='Concrete')
part(4, 'ResearchComplex', (160, 48, 120), (-520, 28, -40), rgb=(214, 239, 255), material='Metal')
part(4, 'RocketPad', (140, 4, 140), (-280, 6, 120), rgb=(130, 130, 130), material='Metal')
part(4, 'EMPArray', (120, 20, 60), (-560, 14, 140), rgb=(70, 237, 255), material='Neon')
for i in range(16):
    part(4, f'EarthWall_{i+1:02d}', (24, 18, 8), (-640 + i * 32, 12, -212), rgb=(100, 140, 170), material='Metal')
spawn(4, 'HumanSpawnMain', (-420, 10, 0), 'Bright blue')
spawn(4, 'HumanLeaderSpawn', (-520, 10, -70), 'Bright blue')
end_item(3)

begin_item('Model', 3, 'PlanetXBase')
part(4, 'PlanetXGround', (620, 8, 520), (500, 4, 0), rgb=(90, 22, 38), material='Concrete')
part(4, 'DeathRayCore', (90, 140, 90), (580, 74, -40), rgb=(255, 46, 189), material='Neon')
part(4, 'AlienArmory', (180, 40, 120), (420, 24, 120), rgb=(129, 63, 94), material='Metal')
part(4, 'ChargeConduit', (220, 12, 18), (560, 20, 70), rgb=(255, 88, 88), material='Neon')
for i in range(16):
    part(4, f'AlienSpire_{i+1:02d}', (18, 52, 18), (300 + i * 24, 28, -220), rgb=(180, 50, 90), material='Metal')
spawn(4, 'AlienSpawnMain', (500, 10, 0), 'Bright red')
spawn(4, 'OvermindSpawn', (420, 10, 130), 'Bright red')
end_item(3)

begin_item('Model', 3, 'Spacefleet')
for i in range(1, 11):
    x = -120 + i * 110
    part(4, f'HumanShipHull_{i:02d}', (72, 14, 30), (x, 70 + (i % 3) * 6, -380), rgb=(90, 170, 255), material='Metal')
    part(4, f'HumanShipEngine_{i:02d}', (14, 14, 14), (x - 40, 70 + (i % 3) * 6, -380), rgb=(70, 237, 255), material='Neon', shape='Ball')
for i in range(1, 11):
    x = 180 + i * 95
    part(4, f'AlienShipHull_{i:02d}', (82, 16, 34), (x, 90 + (i % 4) * 5, 360), rgb=(255, 92, 120), material='Metal')
    part(4, f'AlienShipCore_{i:02d}', (16, 16, 16), (x + 44, 90 + (i % 4) * 5, 360), rgb=(255, 46, 189), material='Neon', shape='Ball')
end_item(3)

begin_item('Folder', 3, 'FuelNodes')
for i in range(1, 61):
    x = -700 + (i % 15) * 90
    z = -160 + (i // 15) * 120
    part(4, f'FuelNode_{i:03d}', (8, 8, 8), (x, 8, z), rgb=(255, 240, 73), material='Neon', shape='Ball')
end_item(3)

begin_item('Folder', 3, 'MapPlaceholders')
string_value(4, 'NOTES', (ROOT / 'Workspace/MapPlaceholders/NOTES.txt').read_text())
begin_item('Folder', 4, 'HyperwaveDesignNodes')
for i in range(1, 401):
    string_value(5, f'Node_{i:03d}', f'Hyperwave custom point {i:03d}: swap with hand-made geometry / objective elements')
end_item(4)
end_item(3)

end_item(2)  # Workspace

# ReplicatedStorage
begin_item('ReplicatedStorage', 2, 'ReplicatedStorage')
begin_item('Folder', 3, 'Modules')
for p in sorted((ROOT / 'ReplicatedStorage/Modules').glob('*.lua')):
    script_with_source(4, 'ModuleScript', p.stem, p.read_text())
end_item(3)

begin_item('Folder', 3, 'Docs')
string_value(4, 'RepositoryREADME', (ROOT / 'README.md').read_text())
end_item(3)
end_item(2)

# ServerScriptService
begin_item('ServerScriptService', 2, 'ServerScriptService')
script_with_source(3, 'Script', 'Main', (ROOT / 'ServerScriptService/Main.server.lua').read_text())
begin_item('Folder', 3, 'Services')
for p in sorted((ROOT / 'ServerScriptService/Services').glob('*.lua')):
    script_with_source(4, 'ModuleScript', p.stem, p.read_text())
end_item(3)
end_item(2)

# StarterGui
begin_item('StarterGui', 2, 'StarterGui')
begin_item('ScreenGui', 3, 'RetrowaveHUD')
script_with_source(4, 'LocalScript', 'Init', (ROOT / 'StarterGui/RetrowaveHUD/Init.client.lua').read_text())
end_item(3)
end_item(2)

# StarterPlayer
begin_item('StarterPlayer', 2, 'StarterPlayer')
begin_item('StarterPlayerScripts', 3, 'StarterPlayerScripts')
for p in sorted((ROOT / 'StarterPlayer/StarterPlayerScripts').glob('*.lua')):
    script_with_source(4, 'LocalScript', p.name.split('.')[0], p.read_text())
end_item(3)
end_item(2)

# Teams preset
begin_item('Teams', 2, 'Teams')
begin_item('Team', 3, 'Lobby', ['<string name="TeamColor">Royal purple</string>', '<bool name="AutoAssignable">false</bool>'])
end_item(3)
begin_item('Team', 3, 'Humans', ['<string name="TeamColor">Bright blue</string>', '<bool name="AutoAssignable">false</bool>'])
end_item(3)
begin_item('Team', 3, 'Aliens', ['<string name="TeamColor">Bright red</string>', '<bool name="AutoAssignable">false</bool>'])
end_item(3)
end_item(2)

end_item(1)  # DataModel
add('</roblox>')

OUT.write_text('\n'.join(lines) + '\n')
print(f'wrote {OUT} with {len(lines)} lines')
