extends Node

signal on_passive_skill_selected(passiveSkillNode: Dictionary)
signal on_golds_collected(goldsCollected: int)
signal on_souls_collected(soulsCollected: int)

signal set_passive_tree_array(passive_tree: Array[Dictionary])
signal load_passive_tree_array(passive_tree: Array[Dictionary])
signal set_data_file_dictionary(data_dictionary: Dictionary)
signal load_data_file_dictionary(data_dictionary: Dictionary)

func emit_on_passive_skill_selected(passiveSkillNode: Dictionary):
	on_passive_skill_selected.emit(passiveSkillNode)
	
func emit_on_golds_collected(goldsCollected: int):
	on_golds_collected.emit(goldsCollected)

func emit_on_souls_collected(soulsCollected: int):
	on_souls_collected.emit(soulsCollected)
	
func emit_set_passive_tree_array(passive_tree: Array[Dictionary]):
	set_passive_tree_array.emit(passive_tree)
	
func emit_load_passive_tree_array(passive_tree: Array[Dictionary]):
	load_passive_tree_array.emit(passive_tree)
	
func emit_set_data_file_dictionary(data_dictionary: Dictionary):
	set_data_file_dictionary.emit(data_dictionary)
	
func emit_load_data_file_dictionary(data_dictionary: Dictionary):
	load_data_file_dictionary.emit(data_dictionary)
