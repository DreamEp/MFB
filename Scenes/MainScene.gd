extends Control
class_name MainNode

@onready var hud: Control = $"HUD&Menus/HUD"

@onready var mainMenu: Control = $"HUD&Menus/MainMenu"
@onready var optionMenu: Control = mainMenu.get_node("OptionsMenu")
@onready var mainMenuContainer: MarginContainer = mainMenu.get_node("MarginContainer")
@onready var main_2d: Node2D = $Main2DScene
@onready var startButton: Button = mainMenuContainer.get_node("VBoxContainer").get_node("HBoxContainer").get_node("VBoxContainer").get_node("StartGame")

var scene_instance : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	startButton.button_down.connect(on_button_down)
	hud.visible = false
	optionMenu.visible = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	#if Input.get_action_strength("menu"):
		#if mainMenu.visible == false:
			#mainMenu.visible = true
		#else:
			#mainMenu.visible = false

func on_button_down():
	load_scene("world")

func unload_scene():
	if(is_instance_valid(scene_instance)):
		scene_instance.queue_free()
	scene_instance = null
	
func load_scene(scene_name : String):
	unload_scene()
	mainMenu.visible = false
	hud.visible = true
	var scene_path := "res://Scenes/%s.tscn" % scene_name
	var scene_resource := load(scene_path)
	if(scene_resource):
		scene_instance = scene_resource.instantiate()
		main_2d.add_child(scene_instance)

