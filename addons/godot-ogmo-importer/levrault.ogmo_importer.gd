tool
extends EditorPlugin

var import_plugin = null
var dock = null


func _get_name():
	return 'Ogmo Map Importer'


func _enter_tree():
	dock = preload('ogmo_dock.tscn').instance()
	print(dock)
	add_control_to_dock(DOCK_SLOT_RIGHT_UR, dock)
	# add_import_plugin(import_plugin)
	# import_plugin = preload('ogmo_import_plugin.gd').new()


func _exit_tree():
	# remove_import_plugin(import_plugin)
	# import_plugin = null
	remove_control_from_docks(dock)
	dock.free()