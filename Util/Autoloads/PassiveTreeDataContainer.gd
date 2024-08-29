extends Node

@onready var passive_tree_resource: SaveResource = preload("res://Resources/Save/Save.tres")

var loaded_data: Array[Dictionary]

func _ready():
	handle_signals()
	create_storage_passive_skill()
	
func create_storage_passive_skill() -> Array[Dictionary]:
	var passive_tree_container_array: Array[Dictionary] = passive_tree_resource.passive_skill_tree
	return passive_tree_container_array

func get_passive_skill_selected():	
	return passive_tree_resource.passive_skill_tree

func set_passive_skill_selected(skillNode: Dictionary):
	var found = false
	for i in range(passive_tree_resource.passive_skill_tree.size()):
		if passive_tree_resource.passive_skill_tree[i].title == skillNode.title:
			passive_tree_resource.passive_skill_tree[i] = skillNode
			found = true
			break
	if not found:
		passive_tree_resource.passive_skill_tree.append(skillNode)

func set_load_passive_tree_array(passive_tree: Array[Dictionary]):
	loaded_data = passive_tree
	for skillNode in loaded_data:
		set_passive_skill_selected(skillNode)
	
func handle_signals():
	SignalBus.on_passive_skill_selected.connect(set_passive_skill_selected)
	SignalBus.load_passive_tree_array.connect(set_load_passive_tree_array)
