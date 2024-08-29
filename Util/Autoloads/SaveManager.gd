extends Node

const SETTINGS_SAVE_PATH: String = "user://SettingsData.save"
const PASSIVES_SAVE_PATH: String = "user://PassivesData.save"
const DATA_SAVE_PATH: String = "user://Data.save"

var settings_data_dict: Dictionary = {}
var passives_data_dict: Array[Dictionary]
var save_data_dict: Dictionary = {}

func _ready():
	#When we call the signal to set the dictionary then we save it
	SettingsSignalBus.set_settings_dictionary.connect(on_settings_save)
	load_settings_data()
	SignalBus.set_passive_tree_array.connect(on_passive_tree_save)
	load_passive_tree_data()
	
func on_settings_save(data: Dictionary):
	var save_settings_data_file = FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.WRITE)
	#var save_settings_data_file = FileAccess.open_encrypted_with_pass(SETTINGS_SAVE_PATH, FileAccess.WRITE, "PO!0asez8s;,DhB74")
	var json_data_string = JSON.stringify(data)
	save_settings_data_file.store_line(json_data_string)

func load_settings_data():
	if not FileAccess.file_exists(SETTINGS_SAVE_PATH):
		return
		
	var save_settings_data_file = FileAccess.open(SETTINGS_SAVE_PATH, FileAccess.READ)
	#var save_settings_data_file = FileAccess.open_encrypted_with_pass(SETTINGS_SAVE_PATH, FileAccess.READ, "PO!0asez8s;,DhB74")
	var loaded_data: Dictionary = {}
	while save_settings_data_file.get_position() < save_settings_data_file.get_length():
		var json_string = save_settings_data_file.get_line()
		var json = JSON.new()
		var _parsed_result = json.parse(json_string)
		loaded_data = json.get_data()
	
	SettingsSignalBus.emit_load_settings_dictionary(loaded_data)
	loaded_data = {}
	
func on_passive_tree_save(data: Array[Dictionary]):
	var save_passive_tree_data_file = FileAccess.open(PASSIVES_SAVE_PATH, FileAccess.WRITE)
	#var save_settings_data_file = FileAccess.open_encrypted_with_pass(SETTINGS_SAVE_PATH, FileAccess.WRITE, "PO!0asez8s;,DhB74")
	var json_data_string = JSON.stringify(data)
	save_passive_tree_data_file.store_line(json_data_string)
	
func load_passive_tree_data():
	if not FileAccess.file_exists(PASSIVES_SAVE_PATH):
		return

	var save_passive_tree_data_file = FileAccess.open(PASSIVES_SAVE_PATH, FileAccess.READ)
	var json_string = save_passive_tree_data_file.get_as_text()
	save_passive_tree_data_file.close()

	var json = JSON.new()
	var _parsed_result = json.parse(json_string)

	if _parsed_result == OK:
		var loaded_data = json.get_data()
		if loaded_data is Array:
			var loaded_data_dict: Array[Dictionary] = []
			for item in loaded_data:
				if item is Dictionary:
					loaded_data_dict.append(item)
				else:
					print("Item is not a dictionary: ", item)
			SignalBus.emit_load_passive_tree_array(loaded_data_dict)
			loaded_data = []
			loaded_data_dict = []
		
func on_save(data: Dictionary):
	var save_data_file = FileAccess.open(DATA_SAVE_PATH, FileAccess.WRITE)
	#var save_settings_data_file = FileAccess.open_encrypted_with_pass(SETTINGS_SAVE_PATH, FileAccess.WRITE, "PO!0asez8s;,DhB74")
	var json_data_string = JSON.stringify(data)
	save_data_file.store_line(json_data_string)

func load_data():
	if not FileAccess.file_exists(DATA_SAVE_PATH):
		return
		
	var save_data_file = FileAccess.open(DATA_SAVE_PATH, FileAccess.READ)
	#var save_settings_data_file = FileAccess.open_encrypted_with_pass(SETTINGS_SAVE_PATH, FileAccess.READ, "PO!0asez8s;,DhB74")
	var loaded_data: Dictionary = {}
	while save_data_file.get_position() < save_data_file.get_length():
		var json_string = save_data_file.get_line()
		var json = JSON.new()
		var _parsed_result = json.parse(json_string)
		loaded_data = json.get_data()
	
	SignalBus.emit_load_data_file_dictionary(loaded_data)
	loaded_data = {}





