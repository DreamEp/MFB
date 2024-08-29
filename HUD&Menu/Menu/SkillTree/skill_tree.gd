extends Control

@onready var exit = $Exit
@onready var mainMenuContainer: NinePatchRect = $"../NinePatchRect"
@onready var collectedSoulGem = $Panel2/CollectedSoulGem

@onready var save_resource: SaveResource = preload("res://Resources/Save/Save.tres")


func _ready():
	collectedSoulGem.text = "180" #Player soulGem
	var all_skill_nodes = get_all_skill_nodes(self)
	for i in all_skill_nodes:
		for j in save_resource.passive_skill_tree:
			if i.passiveSkillNode.title == j.title:
				update_skillNode(i, j)

func _on_exit_pressed():
	self.visible = false
	mainMenuContainer.visible = true
	SignalBus.emit_set_passive_tree_array(PassiveTreeDataContainer.create_storage_passive_skill())
	
func get_all_skill_nodes(node: Node) -> Array:
	var skill_nodes = []
	for child in node.get_children():
		if child is SkillNode:
			skill_nodes.append(child)
			skill_nodes += get_all_skill_nodes(child)
	return skill_nodes
	
func update_skillNode(skillButton: SkillNode, skillNodeDict: Dictionary):
	skillButton.passiveSkillNode.title = skillNodeDict.title
	skillButton.passiveSkillNode.description = skillNodeDict.description
	skillButton.passiveSkillNode.texture_name = skillNodeDict.texture_name
	skillButton.passiveSkillNode.level = skillNodeDict.level
	skillButton.passiveSkillNode.max_level = skillNodeDict.max_level
	skillButton.passiveSkillNode.initial_cost = skillNodeDict.initial_cost
	skillButton.update_skill_node()
	
