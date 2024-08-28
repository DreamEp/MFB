extends Node

const SETTINGS_SAVE_PATH: String = "user://SettingsData.save"
const PASSIVES_SAVE_PATH: String = "user://PassivesData.save"

var settings_data_dict: Dictionary = {}
var passives_data_dict: Dictionary = {}

func _ready():
	#When we call the signal to set the dictionary then we save it
	SettingsSignalBus.set_settings_dictionary.connect(on_settings_save)
	load_settings_data()
	#SignalBus.set_passive_tree_array.connect(on_passive_tree_save)
	#load_passive_tree_data()
	
	#SettingsSignalBus.load_settings_dictionary.connect(load_settings_data)
	
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
	
func on_passive_tree_save(data: Array[PassiveSkillNode]):
	var save_passive_tree_data_file = FileAccess.open(PASSIVES_SAVE_PATH, FileAccess.WRITE)
	#var save_settings_data_file = FileAccess.open_encrypted_with_pass(SETTINGS_SAVE_PATH, FileAccess.WRITE, "PO!0asez8s;,DhB74")
	var json_data_string = JSON.stringify(data)
	save_passive_tree_data_file.store_line(json_data_string)
	
func load_passive_tree_data():
	if not FileAccess.file_exists(PASSIVES_SAVE_PATH):
		return
	
	var save_passive_tree_data_file = FileAccess.open(PASSIVES_SAVE_PATH, FileAccess.READ)
	#var save_settings_data_file = FileAccess.open_encrypted_with_pass(SETTINGS_SAVE_PATH, FileAccess.READ, "PO!0asez8s;,DhB74")
	var loaded_data: Array[PassiveSkillNode]
	
	while save_passive_tree_data_file.get_position() < save_passive_tree_data_file.get_length():
		var json_string = save_passive_tree_data_file.get_line()
		var json = JSON.new()
		var _parsed_result = json.parse(json_string)
		
		loaded_data = json.get_data()
	
	SignalBus.emit_load_passive_tree_array(loaded_data)
	loaded_data = []
