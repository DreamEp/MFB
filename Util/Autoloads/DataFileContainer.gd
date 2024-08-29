extends Node

@onready var save_resource: SaveResource = preload("res://Resources/Save/Save.tres")

var loaded_data: Dictionary = {}

func _ready():
	handle_signals()
	create_storage_dictionary()
	
func create_storage_dictionary() -> Dictionary:
	var save_container_dict: Dictionary = {
		save_resource.COLLECTED_SOULS: save_resource.collected_souls,
		save_resource.COLLECTED_GOLDS: save_resource.collected_golds
	}
	return save_container_dict

func get_collected_souls():	
	return save_resource.collected_souls
	
func get_collected_golds():	
	return save_resource.collected_golds

func set_collected_souls(collected_souls: int):
	save_resource.collected_souls += collected_souls
	
func set_collected_golds(collected_golds: int):
	save_resource.collected_golds += collected_golds
	
func set_load_data_file_dictionary(data_dict: Dictionary):
	loaded_data = data_dict
	set_collected_souls(loaded_data.collected_souls)
	set_collected_golds(loaded_data.collected_golds)
	
func handle_signals():
	SignalBus.on_souls_collected.connect(set_collected_souls)
	SignalBus.on_golds_collected.connect(set_collected_golds)
	SignalBus.load_data_file_dictionary.connect(set_load_data_file_dictionary)
