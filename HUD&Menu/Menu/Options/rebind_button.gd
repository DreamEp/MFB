extends Control
class_name RebindButton

@onready var label: Label = $HBoxContainer/Label
@onready var button: Button = $HBoxContainer/Button
@export var action_name: String = "menu"

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_keys()
	load_keybinds()
	
func load_keybinds():
	rebind_action_key(SettingsDataContainer.get_keybind(action_name))

func set_action_name():
	label.text = "Unassigned"
	match action_name:
		"up":
			label.text = "Move Up"
		"down":
			label.text = "Move Down"
		"left":
			label.text = "Move Left"
		"right":
			label.text = "Move Right"
		"menu":
			label.text = "Menu"
			
func set_text_for_keys():
	var action_events = InputMap.action_get_events(action_name)
	var action_event = action_events[0]
	var action_keycode = OS.get_keycode_string(action_event.physical_keycode)
	
	button.text = "%s" % action_keycode


func _on_button_toggled(button_pressed):
	if button_pressed:
		button.text = "Press any key.."
		set_process_unhandled_key_input(button_pressed)
		
		for i in get_tree().get_nodes_in_group("rebind_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = false
				i.set_process_unhandled_key_input(false)
	else:
		
		for i in get_tree().get_nodes_in_group("rebind_button"):
			if i.action_name != self.action_name:
				i.button.toggle_mode = true
				i.set_process_unhandled_key_input(false)
		set_text_for_keys()

func _unhandled_key_input(event):
	rebind_action_key(event)
	button.button_pressed = false
	
func rebind_action_key(event):
	InputMap.action_erase_events(action_name)
	InputMap.action_add_event(action_name, event)
	
	SettingsDataContainer.set_keybind(action_name, event)
	
	set_process_unhandled_key_input(false)
	set_text_for_keys()
	set_action_name()
