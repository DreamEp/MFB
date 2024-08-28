extends Node

signal on_passive_skill_selected(passiveSkillNode: PassiveSkillNode)

signal set_passive_tree_array(passive_tree: Array[PassiveSkillNode])
signal load_passive_tree_array(passive_tree: Array[PassiveSkillNode])

func emit_on_passive_skill_selected(passiveSkillNode: PassiveSkillNode):
	on_passive_skill_selected.emit(passiveSkillNode)
	
func emit_set_passive_tree_array(passive_tree: Array[PassiveSkillNode]):
	set_passive_tree_array.emit(passive_tree)
	
func emit_load_passive_tree_array(passive_tree: Array[PassiveSkillNode]):
	load_passive_tree_array.emit(passive_tree)
