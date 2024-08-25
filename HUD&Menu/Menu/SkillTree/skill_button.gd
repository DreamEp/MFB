extends TextureButton
class_name SkillNode

@onready var panel = $Panel
@onready var label = $MarginContainer/Label
@onready var line2d = $Line2D

@export var textureName: String
@export var level: int
@export var max_level: int

var descriptionPanel: Panel 
var descriptionLabel: Label 

func _ready():
	self.texture_normal = load("res://Art/UI/PassiveTree/%s.png" % textureName)
	label.text = str(level) + "/" + str(max_level)
	if get_parent() is SkillNode:
		line2d.add_point(global_position + size/2)
		line2d.add_point(get_parent().global_position + size/2)
		
	descriptionPanel = get_owner().get_node("Panel")
	descriptionLabel = descriptionPanel.get_node("Label")

func _on_pressed():
	level = min (level+1, max_level)
	label.text = str(level) + "/" + str(max_level)
	panel.show_behind_parent = true
	
	line2d.default_color = Color(0.957, 0.886, 0.776)
	
	var passives = get_children()
	for passive in passives:
		#if passive is SkillNode and level == 1:
			#passive.disabled = false
		if passive is SkillNode and level == passive.max_level:
			passive.disabled = false		


func _on_mouse_entered():
	descriptionLabel.text = "Increase the value of %s" % textureName
	descriptionPanel.visible = true


func _on_mouse_exited():
	descriptionPanel.visible = false
