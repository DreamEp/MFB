class_name SettingsTabContainer
extends Control

@onready var tabContainer: TabContainer = $TabContainer

signal exit_option_menu

func _ready():
	pass # Replace with function body.


func _process(_delta):
	option_menu_input()

func change_tab(tab: int):
	tabContainer.set_current_tab(tab)
	
func option_menu_input():
	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("ui_right"):
		if tabContainer.current_tab >= tabContainer.get_tab_count() - 1 :
			change_tab(0)
		var next_tab = tabContainer.current_tab + 1
		change_tab(next_tab)
	if Input.is_action_just_pressed("left") or Input.is_action_just_pressed("ui_left"):
		if tabContainer.current_tab <= 0 :
			change_tab(tabContainer.get_tab_count() - 1)
		var previous_tab = tabContainer.current_tab - 1
		change_tab(previous_tab)
		
	if Input.is_action_just_pressed("ui_cancel"):
		exit_option_menu.emit()
