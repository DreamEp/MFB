extends Control

@onready var state_label: Label = $HBoxContainer/StateLabel
@onready var check_button: CheckButton = $HBoxContainer/CheckButton

func _ready():
	_on_check_button_toggled(SettingsDataContainer.get_auto_aim_toggled())

func set_label_text(toggled_on):
	if toggled_on != true:
		state_label.text = "Off"
	else:
		state_label.text = "On"
		
func set_button_toggled(toggled_on):
	check_button.button_pressed = toggled_on

func _on_check_button_toggled(toggled_on):
	set_label_text(toggled_on)
	set_button_toggled(toggled_on)
	SettingsSignalBus.emit_on_auto_aim_toggled(toggled_on)

