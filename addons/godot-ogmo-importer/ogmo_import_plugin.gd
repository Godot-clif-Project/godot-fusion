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
	return [
		{
			'name': 'image_flags',
			'default_value': 0 if preset == PRESET_PIXEL_ART else Texture.FLAGS_DEFAULT,
			'property_hint': PROPERTY_HINT_FLAGS,
			'hint_string': 'Mipmaps,Repeat,Filter,Anisotropic,sRGB,Mirrored Repeat'
		},
		{
			'name': 'embed_internal_images',
			'default_value': true if preset == PRESET_PIXEL_ART else false
		}
	]


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