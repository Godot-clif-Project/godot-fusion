tool
extends VBoxContainer

var import_plugin = null

func _enter_tree():
	import_plugin = preload('ogmo_import_plugin.gd').new()
	add_import_plugin(import_plugin)


func _exit_tree():
	remove_import_plugin(import_plugin)
	import_plugin = null
	remove_control_from_docks(dock)
	dock.free()

func _ready():
	$TilesetButton.connect('button_down', self, '_on_TilesetButton_click')
	$TilemapButton.connect('button_down', self, '_on_TilemapButton_click')


func _on_TilesetButton_click():
	print('_on_TilesetButton_click')


func _on_TilemapButton_click():
	print('_on_TilemapButton_click')