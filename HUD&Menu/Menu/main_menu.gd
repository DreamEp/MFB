extends Control
class_name MainMenu

@onready var optionMenu: OptionMenu = $OptionsMenu
@onready var mainMenuContainer: NinePatchRect = $NinePatchRect

func _process(_delta):
	pass
	#if Input.get_action_strength("menu"):
		#if optionMenu.visible == false:
			#optionMenu.visible = true
			#get_tree().paused = true
		#else:
			#optionMenu.visible = false
			#get_tree().paused = false
			
func _ready():
	pass

#MAIN MENU
func _on_quit_game_pressed():
	get_tree().quit()

func _on_options_pressed():
	mainMenuContainer.visible = false
	optionMenu.visible = true
