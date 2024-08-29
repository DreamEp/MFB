extends Node2D

@onready var mainMenu: Control = get_tree().get_first_node_in_group("menu")
@onready var marginContainer: NinePatchRect = mainMenu.get_node("NinePatchRect")
@onready var optionMenu: Control = mainMenu.get_node("OptionsMenu")


func _ready():
	pass 


func _process(_delta):
	if Input.is_action_just_pressed("menu"):
		if marginContainer.visible == false:
			get_tree().paused = true
			marginContainer.visible = true
			optionMenu.visible = true
		else:
			get_tree().paused = false
			marginContainer.visible = false
			optionMenu.visible = false
