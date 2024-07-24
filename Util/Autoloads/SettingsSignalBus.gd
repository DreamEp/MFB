extends Node

signal on_window_mode_selected(index: int)
signal on_resolution_selected(index: int)
signal on_master_volume_set(value: float)
signal on_music_volume_set(value: float)
signal on_sfx_volume_set(value: float)
signal on_auto_aim_toggled(toggled: bool)
signal on_auto_attacks_toggled(toggled: bool)

signal set_settings_dictionary(settings_dict: Dictionary)
signal load_settings_dictionary(settings_dict: Dictionary)

func emit_on_window_mode_selected(index: int):
	on_window_mode_selected.emit(index)

func emit_on_resolution_selected(index: int):
	on_resolution_selected.emit(index)

func emit_on_master_volume_set(value: float):
	on_master_volume_set.emit(value)
	
func emit_on_music_volume_set(value: float):
	on_music_volume_set.emit(value)
	
func emit_on_sfx_volume_set(value: float):
	on_sfx_volume_set.emit(value)

func emit_on_auto_aim_toggled(toggled: bool):
	on_auto_aim_toggled.emit(toggled)

func emit_on_auto_attacks_toggled(toggled: bool):
	on_auto_attacks_toggled.emit(toggled)

func emit_set_settings_dictionary(settings_dict: Dictionary):
	set_settings_dictionary.emit(settings_dict)
	
func emit_load_settings_dictionary(settings_dict: Dictionary):
	load_settings_dictionary.emit(settings_dict)
