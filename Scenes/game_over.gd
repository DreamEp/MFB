extends Control

@onready var time_alive = $NinePatchRect/Stats/TimeAlive
@onready var souls_collected = $NinePatchRect/Stats/Collectibles/SoulsCollected
@onready var golds_collected = $NinePatchRect/Stats/Collectibles/GoldsCollected
@onready var spawnerNode: EnemySpawner = get_tree().get_first_node_in_group("spawner")
@onready var playerNode: Player = get_tree().get_first_node_in_group("player")
@onready var mainNode: MainNode = get_tree().get_first_node_in_group("main_scene")


func _ready():
	SignalBus.emit_on_souls_collected(10*spawnerNode.pass_time)
	SignalBus.emit_on_golds_collected(playerNode.collected_golds)
	time_alive.text = "You stayed alive : %s" % seconds_to_mm_ss(spawnerNode.time)
	souls_collected.text = "Collected souls : %s"
	golds_collected.text = "Collected golds : %s"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func seconds_to_mm_ss(seconds: int) -> String:
	var minutes = seconds / 60
	var remaining_seconds = seconds % 60
	return str(minutes).pad_zeros(2) + ":" + str(remaining_seconds).pad_zeros(2)

func _on_restart_game_pressed():
	mainNode.load_scene("world")

func _on_main_scene_pressed():
	mainNode.hud.visible = false
	mainNode.optionMenu.visible = false
	mainNode.mainMenu.visible = true


func _on_quit_game_pressed():
	get_tree().quit()
