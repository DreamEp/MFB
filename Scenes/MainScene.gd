extends Control
class_name MainNode

@onready var hud: Control = $"HUD&Menus/PlayerHUD"

@onready var mainMenu: Control = $"HUD&Menus/MainMenu"
@onready var optionMenu: Control = mainMenu.get_node("OptionsMenu")
@onready var mainMenuContainer: NinePatchRect = mainMenu.get_node("NinePatchRect")
@onready var main_2d: Node2D = $Main2DScene
@onready var startButton: Button = mainMenuContainer.get_node("HBoxContainer").get_node("VBoxContainer").get_node("StartGame")

var scene_instance

func _ready():
	startButton.button_down.connect(on_button_down)
	hud.visible = false
	optionMenu.visible = false
	
func _process(_delta):
	pass

func on_button_down():
	load_scene("world")

func unload_scene():
	##Add golds / souls collected
	if(is_instance_valid(scene_instance)):
		scene_instance.queue_free()
	scene_instance = null
	
func load_scene(scene_name : String):
	unload_scene()
	mainMenu.visible = false
	var scene_path := "res://Scenes/%s.tscn" % scene_name
	var scene_resource := load(scene_path)
	if(scene_resource):
		scene_instance = scene_resource.instantiate()
		if(scene_name != "game_over"):
			hud.visible = true
			main_2d.add_child(scene_instance)
		else:
			hud.visible = false
			self.add_child(scene_instance)
			
	
	
