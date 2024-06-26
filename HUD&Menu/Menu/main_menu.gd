extends Control
class_name MainMenu

@onready var optionMenu: OptionMenu = $OptionsMenu
@onready var mainMenuContainer: MarginContainer = $MarginContainer

func _ready():
	pass

#MAIN MENU
func _on_quit_game_pressed():
	get_tree().quit()

func _on_options_pressed():
	mainMenuContainer.visible = false
	optionMenu.visible = true
