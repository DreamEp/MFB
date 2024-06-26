extends Control
class_name Rebindbutton

@onready var label: Label = $HBoxContainer/Label
@onready var button: Button = $HBoxContainer/Button
@export var action_name: String = "menu"

func _ready():
	set_process_unhandled_key_input(false)
	set_action_name()
	set_text_for_keys()

func set_action_name():
	label.text = "Unassigned"
	match action_name:
		"menu":
			label.text = "Menu"
		"up":
			label.text = "Move Up"
		"left":
			label.text = "Move Left"
		"right":
			label.text = "Move Right"
		"down":
			label.text = "Move Down"
			
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
	
	set_process_unhandled_key_input(false)
	set_text_for_keys()
	set_action_name()
