extends Control

@onready var hud : Control = $HUD
@onready var menu : Control = $Menu
@onready var main_2d : Node2D = $Main2DScene

var scene_instance : Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func unload_scene():
	if(is_instance_valid(scene_instance)):
		scene_instance.queue_free()
	scene_instance = null
	
func load_scene(scene_name : String):
	unload_scene()
	menu.visible = false
	var scene_path := "res://Scenes/%s.tscn" % scene_name
	var scene_resource := load(scene_path)
	if(scene_resource):
		scene_instance = scene_resource.instantiate()
		main_2d.add_child(scene_instance)

func _on_play_pressed():
	load_scene("world")

func _on_quit_pressed():
	get_tree().quit()
