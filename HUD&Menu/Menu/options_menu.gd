extends Control
class_name OptionMenu

@onready var mainMenuContainer: NinePatchRect = $"../NinePatchRect"
@onready var settingsTabContainer: Control = $MarginContainer/VBoxContainer/SettingsTabContainer

func _ready():
	settingsTabContainer.exit_option_menu.connect(_on_exit_pressed)


func _on_exit_pressed():
	self.visible = false
	mainMenuContainer.visible = true
	SettingsSignalBus.emit_set_settings_dictionary(SettingsDataContainer.create_storage_dictionary())
