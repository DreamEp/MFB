extends Node

@onready var passive_tree_resource: SaveResource = preload("res://Resources/Save/Save.tres")

var loaded_data: Array[PassiveSkillNode]

func _ready():
	handle_signals()
	create_storage_passive_skill()
	
func create_storage_passive_skill() -> Array[PassiveSkillNode]:
	var passive_tree_container_array: Array[PassiveSkillNode] = passive_tree_resource.passive_skill_tree
	return passive_tree_container_array

func get_passive_skill_selected():	
	return passive_tree_resource.passive_skill_tree

func set_passive_skill_selected(skillNode: PassiveSkillNode):
	passive_tree_resource.passive_skill_tree.append(skillNode)
	
func set_load_passive_tree_array(passive_tree: Array[PassiveSkillNode]):
	loaded_data = passive_tree
	for skillNode in loaded_data:
		set_passive_skill_selected(skillNode)
	
func handle_signals():
	SignalBus.on_passive_skill_selected.connect(set_passive_skill_selected)
	SignalBus.load_passive_tree_array.connect(set_load_passive_tree_array)
