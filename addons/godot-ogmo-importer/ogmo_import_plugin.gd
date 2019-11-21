tool
extends EditorImportPlugin

enum { PRESET_DEFAULT, PRESET_PIXEL_ART }

const OgmoFileReader = preload('ogmo_file_reader.gd')

func get_importer_name():
	return 'levrault.ogmo_importer'


func get_visible_name():
	return 'Scene from Ogmo'


func get_recognized_extensions():
	return ['json', 'ogmo']


func get_save_extension():
	return 'scn'


func get_priority():
	return 1


func get_import_order():
	return 100


func get_resource_type():
	return 'PackedScene'


func get_preset_count():
	return 2


func get_preset_name(preset):
	match preset:
		PRESET_DEFAULT: return 'Default'
		PRESET_PIXEL_ART: return 'Pixel Art'


func get_import_options(preset):
	return []

func get_option_visibility(option, options):
	return true


func import(source_file, save_path, options, r_platform_variants, r_gen_files):
	var reader = null
	var scene = null

	# Read JSON/OGMO
	var file = File.new()
	var err = file.open(source_file, File.READ)
	if err != OK:
		return err

	var content = JSON.parse(file.get_as_text())
	if content.error != OK:
		printerr('Error parsing OGMO: ' + content.error_string)
		return content.error

	# ogmo file extension
	if source_file.get_extension().to_lower() == 'ogmo':
		reader = OgmoFileReader.new()
		scene = reader.build(content.result, options)