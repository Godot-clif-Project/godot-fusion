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


func build(config, options):
	build_tileset_for_scene(config.tilesets)


func build_tileset_for_scene(tilesets):
	var result = TileSet.new()
	var err = ERR_INVALID_DATA
	var meta = {}

	for tileset in tilesets:
		var image = null
		# image
		# load from path
		if not tileset.path.empty():
			image = ResourceLoader.load(tileset.path, 'ImageTexture')
			result.tile_set_texture(0, image)
		else: # load from base64
			var img = Image.new()
			img.load_png_from_buffer(Marshalls.base64_to_raw(tileset.image))
			image.set_data(img)

		# props
		var separation = Vector2(tileset.tileSeparationX, tileset.tileSeparationY)
		var tileSize = Vector2(tileset.tileWidth, tileset.tileHeight)
		# var tileCount = image.size

		print(image)

	return result

