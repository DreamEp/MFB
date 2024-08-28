extends TextureButton
class_name SkillNode

@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@onready var line2d = $Line2D

@export var passiveSkillNode: PassiveSkillNode

var descriptionPanel: Panel 
var descriptionLabel: Label 

func _ready():
	self.texture_normal = load("res://Art/UI/PassiveTree/%s.png" % passiveSkillNode.texture_name)
	label.text = str(passiveSkillNode.level) + "/" + str(passiveSkillNode.max_level)
	if get_parent() is SkillNode:
		line2d.add_point(global_position + size/2)
		line2d.add_point(get_parent().global_position + size/2)
		
	descriptionPanel = get_owner().get_node("Panel")
	descriptionLabel = descriptionPanel.get_node("Label")

func _on_pressed():
	passiveSkillNode.level = min(passiveSkillNode.level+1, passiveSkillNode.max_level)
	label.text = str(passiveSkillNode.level) + "/" + str(passiveSkillNode.max_level)
	panel.show_behind_parent = true
	
	line2d.default_color = Color(0.957, 0.886, 0.776)
	
	var passives = get_children()
	for passive in passives:
		#if passive is SkillNode and level == 1:
			#passive.disabled = false
		if passive is SkillNode and passiveSkillNode.level == passiveSkillNode.max_level:
			passive.disabled = false		


func _on_mouse_entered():
	descriptionLabel.text = passiveSkillNode.description
	descriptionPanel.visible = true


func _on_mouse_exited():
	descriptionPanel.visible = false
