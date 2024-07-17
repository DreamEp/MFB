extends Node

@onready var settings_resource: DefaultSettingsResource = preload("res://Resources/Settings/DefaultSettings.tres")
@onready var keybinds_resource: PlayerKeybindsResource = preload("res://Resources/Settings/DefaultPlayerKeybinds.tres")

var loaded_data: Dictionary = {}

func _ready():
	handle_signals()
	create_storage_dictionary()
	
func create_storage_dictionary() -> Dictionary:
	var settings_container_dict: Dictionary = {
		settings_resource.NAME_WINDOW_MODE_INDEX: settings_resource.window_mode_index,
		settings_resource.NAME_RESOLUTION_INDEX: settings_resource.resolution_index,
		settings_resource.NAME_MASTER_VOLUME: settings_resource.master_volume,
		settings_resource.NAME_MUSIC_VOLUME: settings_resource.music_volume,
		settings_resource.NAME_SFX_VOLUME: settings_resource.sfx_volume,
		settings_resource.NAME_AUTO_AIM_STATE: settings_resource.auto_aim_state,
		"keybinds": create_keybinds_dictionary()
	}
	return settings_container_dict

func create_keybinds_dictionary() -> Dictionary:
	var keybinds_container_dict: Dictionary = {
		keybinds_resource.UP: keybinds_resource.up_key,
		keybinds_resource.DOWN: keybinds_resource.down_key,
		keybinds_resource.LEFT: keybinds_resource.left_key,
		keybinds_resource.RIGHT: keybinds_resource.right_key,
		keybinds_resource.MENU: keybinds_resource.menu_key
	}
	return keybinds_container_dict
	
func get_window_mode_index():
	if loaded_data == {}:
		return settings_resource.DEFAULT_WINDOW_MODE_INDEX	
	return settings_resource.window_mode_index

func get_resolution_index():
	if loaded_data == {}:
		return settings_resource.DEFAULT_RESOLUTION_INDEX	
	return settings_resource.resolution_index
	
func get_master_volume():
	if loaded_data == {}:
		return settings_resource.DEFAULT_MASTER_VOLUME	
	return settings_resource.master_volume
	
func get_music_volume():
	if loaded_data == {}:
		return settings_resource.DEFAULT_MUSIC_VOLUME	
	return settings_resource.music_volume
	
func get_sfx_volume():
	if loaded_data == {}:
		return settings_resource.DEFAULT_SFX_VOLUME	
	return settings_resource.sfx_volume
	
func get_auto_aim_toggled():
	if loaded_data == {}:
		return settings_resource.DEFAULT_AUTO_AIM_STATE	
	return settings_resource.auto_aim_state
	
func get_keybind(action: String):
	if !loaded_data.has("keybinds"):
		match action:
			keybinds_resource.UP:
				return keybinds_resource.DEFAULT_UP_KEY
			keybinds_resource.DOWN:
				return keybinds_resource.DEFAULT_DOWN_KEY
			keybinds_resource.LEFT:
				return keybinds_resource.DEFAULT_LEFT_KEY
			keybinds_resource.RIGHT:
				return keybinds_resource.DEFAULT_RIGHT_KEY
			keybinds_resource.MENU:
				return keybinds_resource.DEFAULT_MENU_KEY
	else:
		match action:
			keybinds_resource.UP:
				return keybinds_resource.up_key
			keybinds_resource.DOWN:
				return keybinds_resource.down_key
			keybinds_resource.LEFT:
				return keybinds_resource.left_key
			keybinds_resource.RIGHT:
				return keybinds_resource.right_key
			keybinds_resource.MENU:
				return keybinds_resource.menu_key

func set_window_mode_selected(index: int):
	settings_resource.window_mode_index = index
	
func set_resolution_selected(index: int):
	settings_resource.resolution_index = index
	
func set_master_volume(value: float):
	settings_resource.master_volume = value

func set_music_volume(value: float):
	settings_resource.music_volume = value
	
func set_sfx_volume(value: float):
	settings_resource.sfx_volume = value
	
func set_auto_aim_toggled(toggled: bool):
	settings_resource.auto_aim_state = toggled
	
func set_keybind(action: String, event):
	match action:
		keybinds_resource.UP:
			keybinds_resource.up_key = event
		keybinds_resource.DOWN:
			keybinds_resource.down_key = event
		keybinds_resource.LEFT:
			keybinds_resource.left_key = event
		keybinds_resource.RIGHT:
			keybinds_resource.right_key = event
		keybinds_resource.MENU:
			keybinds_resource.menu_key = event
	
func on_keybinds_loaded(keybinds_dict: Dictionary):
	var loaded_up: InputEventKey = InputEventKey.new()
	var loaded_down: InputEventKey = InputEventKey.new()
	var loaded_left: InputEventKey = InputEventKey.new()
	var loaded_right: InputEventKey = InputEventKey.new()
	var loaded_menu: InputEventKey = InputEventKey.new()
	
	loaded_up.set_physical_keycode(int(keybinds_dict.up))
	loaded_down.set_physical_keycode(int(keybinds_dict.down))
	loaded_left.set_physical_keycode(int(keybinds_dict.left))
	loaded_right.set_physical_keycode(int(keybinds_dict.right))
	loaded_menu.set_physical_keycode(int(keybinds_dict.menu))
	
	keybinds_resource.up_key = loaded_up
	keybinds_resource.down_key = loaded_down
	keybinds_resource.left_key = loaded_left
	keybinds_resource.right_key = loaded_right
	keybinds_resource.menu_key = loaded_menu
	
func set_load_settings_dictionary(settings_dict: Dictionary):
	loaded_data = settings_dict
	set_window_mode_selected(loaded_data.window_mode_index)
	set_resolution_selected(loaded_data.resolution_index)
	set_master_volume(loaded_data.master_volume)
	set_music_volume(loaded_data.music_volume)
	set_sfx_volume(loaded_data.sfx_volume)
	set_auto_aim_toggled(loaded_data.auto_aim_state)
	on_keybinds_loaded(loaded_data.keybinds)
	
func handle_signals():
	SettingsSignalBus.on_window_mode_selected.connect(set_window_mode_selected)
	SettingsSignalBus.on_resolution_selected.connect(set_resolution_selected)
	SettingsSignalBus.on_master_volume_set.connect(set_master_volume)
	SettingsSignalBus.on_music_volume_set.connect(set_music_volume)
	SettingsSignalBus.on_sfx_volume_set.connect(set_sfx_volume)
	SettingsSignalBus.on_auto_aim_toggled.connect(set_auto_aim_toggled)
	SettingsSignalBus.load_settings_dictionary.connect(set_load_settings_dictionary)
