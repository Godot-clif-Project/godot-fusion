# e.g.
#{
#  "name": "PurplyRoom",
#  "levelPaths": ["."],
#  "backgroundColor": "#282c34ff",
#  "gridColor": "#3c4049cc",
#  "anglesRadians": true,
#  "directoryDepth": 5,
#  "levelDefaultSize": {"x": 320, "y": 240},
#  "levelMinSize": {"x": 128, "y": 128},
#  "levelMaxSize": {"x": 4096, "y": 4096},
#  "levelValues": [],
#  "defaultExportMode": ".json",
#  "entityTags": ["player"],
#  "layers": [
#    {
#      "definition": "tile",
#      "name": "Tiles",
#      "gridSize": {"x": 16, "y": 16},
#      "exportID": "15037259",
#      "exportMode": 0,
#      "arrayMode": 0,
#      "defaultTileset": "Tiles"
#    },
#    {
#      "definition": "entity",
#      "name": "Player",
#      "gridSize": {"x": 8, "y": 8},
#      "exportID": "15294110",
#      "requiredTags": ["player"],
#      "excludedTags": []
#    }
#  ],
#}
tool
extends Reference

# ogmo file props
var name: String = ''
var levelPaths: Array = []
var anglesRadians: bool = true
var levelDefaultSize: Vector2 = Vector2.ZERO
var levelMinSize: Vector2 = Vector2.ZERO
var levelMaxSize: Vector2 = Vector2.ZERO
var levelValues: Array = []
var entityTags: Array = []

# ogmo_entity
var entities: Array = []
#ogmo_tileset
var tilesets: Array = []

var OgmoTileset = preload('ogmo_tileset.gd')


func build(config, options):
	for t in config.tilesets:
		var tileset = OgmoTileset.new()
		tileset.build(t)
		tilesets.append(tileset)