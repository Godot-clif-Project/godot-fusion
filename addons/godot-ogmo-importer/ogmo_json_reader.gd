tool
extends Reference


func build(source_path, options):
	var map = read_file(source_path)
	print(map)


# Reads a file and returns its contents as a dictionary
# Returns an error code if fails
func read_file(path):
	var ogmo_file = path.get_extension().to_lower() == 'ogmo'
		
	# Read JSON/OGMO
	var file = File.new()
	var err = file.open(path, File.READ)
	if err != OK:
		return err

	var content = JSON.parse(file.get_as_text())
	if content.error != OK:
		printerr('Error parsing JSON: ' + content.error_string)
		return content.error

	return content.result
