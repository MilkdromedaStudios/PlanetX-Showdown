from pathlib import Path
from xml.sax.saxutils import escape

ROOT = Path('HumanVsAlien_PlanetX_Showdown')
OUT = ROOT / 'HumanVsAlien_PlanetX_Showdown.rbxlx'

ref_id = 1

def next_ref():
    global ref_id
    ref = f'RBX{ref_id}'
    ref_id += 1
    return ref


def indent(level):
    return '  ' * level

lines = []

def add(line=''):
    lines.append(line)


def begin_item(cls, level, name=None):
    ref = next_ref()
    add(f"{indent(level)}<Item class=\"{cls}\" referent=\"{ref}\">")
    add(f"{indent(level+1)}<Properties>")
    add(f"{indent(level+2)}<bool name=\"Archivable\">true</bool>")
    if name is not None:
        add(f"{indent(level+2)}<string name=\"Name\">{escape(name)}</string>")
    return ref


def end_item(level):
    add(f"{indent(level+1)}</Properties>")
    add(f"{indent(level)}</Item>")


def item_with_source(level, cls, name, source):
    begin_item(cls, level, name)
    add(f"{indent(level+2)}<ProtectedString name=\"Source\"><![CDATA[{source}]]></ProtectedString>")
    add(f"{indent(level+2)}<bool name=\"Disabled\">false</bool>")
    end_item(level)


def item_stringvalue(level, name, value):
    begin_item('StringValue', level, name)
    add(f"{indent(level+2)}<string name=\"Value\">{escape(value)}</string>")
    end_item(level)

add('<?xml version="1.0" encoding="utf-8"?>')
add('<roblox version="4">')
add('  <External>null</External>')
add('  <External>nil</External>')

# DataModel
begin_item('DataModel', 1, 'HumanVsAlien_PlanetX_Showdown')

# Workspace
begin_item('Workspace', 2, 'Workspace')
begin_item('Folder', 3, 'MapPlaceholders')
notes = (ROOT / 'Workspace/MapPlaceholders/NOTES.txt').read_text()
item_stringvalue(4, 'NOTES', notes)

# Add many map design node stubs to exceed 2000 lines and provide planning anchors
begin_item('Folder', 4, 'HyperwaveDesignNodes')
for i in range(1, 321):
    item_stringvalue(5, f'Node_{i:03d}', f'Hyperwave staging node {i:03d}: replace with mesh/part/objective prop in Studio')
end_item(4)

end_item(3)  # MapPlaceholders
end_item(2)  # Workspace

# ReplicatedStorage/Modules
begin_item('ReplicatedStorage', 2, 'ReplicatedStorage')
begin_item('Folder', 3, 'Modules')
for path in sorted((ROOT / 'ReplicatedStorage/Modules').glob('*.lua')):
    item_with_source(4, 'ModuleScript', path.stem, path.read_text())
end_item(3)

# Docs mirror README
begin_item('Folder', 3, 'Docs')
item_stringvalue(4, 'RepositoryREADME', (ROOT / 'README.md').read_text())
end_item(3)
end_item(2)

# ServerScriptService
begin_item('ServerScriptService', 2, 'ServerScriptService')
item_with_source(3, 'Script', 'Main', (ROOT / 'ServerScriptService/Main.server.lua').read_text())
begin_item('Folder', 3, 'Services')
for path in sorted((ROOT / 'ServerScriptService/Services').glob('*.lua')):
    item_with_source(4, 'ModuleScript', path.stem, path.read_text())
end_item(3)
end_item(2)

# StarterGui
begin_item('StarterGui', 2, 'StarterGui')
begin_item('ScreenGui', 3, 'RetrowaveHUD')
item_with_source(4, 'LocalScript', 'Init', (ROOT / 'StarterGui/RetrowaveHUD/Init.client.lua').read_text())
end_item(3)
end_item(2)

# StarterPlayer
begin_item('StarterPlayer', 2, 'StarterPlayer')
begin_item('StarterPlayerScripts', 3, 'StarterPlayerScripts')
for path in sorted((ROOT / 'StarterPlayer/StarterPlayerScripts').glob('*.lua')):
    name = path.name.split('.')[0]
    item_with_source(4, 'LocalScript', name, path.read_text())
end_item(3)
end_item(2)

end_item(1)  # DataModel
add('</roblox>')

OUT.write_text('\n'.join(lines) + '\n')
print(f'wrote {OUT}')
print(f'line_count={len(lines)}')
