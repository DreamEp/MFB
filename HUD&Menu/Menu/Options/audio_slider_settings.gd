extends Control

@onready var AudioName:Label = $HBoxContainer/AudioName
@onready var hSlider: HSlider = $HBoxContainer/HSlider
@onready var AudioNumber: Label = $HBoxContainer/AudioNumber

@export_enum("Master", "Music", "SFX") var bus_name: String

var bus_index: int = 0

func _ready():
	get_bus_name_by_index()
	load_data()
	set_label_name_text()
	set_slider_value()
	
func load_data():
	match bus_name:
		"Master":
			_on_h_slider_value_changed(SettingsDataContainer.get_master_volume())
		"Music":
			_on_h_slider_value_changed(SettingsDataContainer.get_music_volume())
		"SFX":
			_on_h_slider_value_changed(SettingsDataContainer.get_sfx_volume())
	
func set_label_name_text():
	AudioName.text = str(bus_name) + " Volume"
	
func set_label_number_text():
	AudioNumber.text = str(hSlider.value * 100)

func get_bus_name_by_index():
	bus_index = AudioServer.get_bus_index(bus_name)

func set_slider_value():
	hSlider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	set_label_number_text()

func _on_h_slider_value_changed(value):
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
	set_label_number_text()
	
	match bus_index:
		0:
			SettingsSignalBus.emit_on_master_volume_set(value)
		1:
			SettingsSignalBus.emit_on_music_volume_set(value)
		2:
			SettingsSignalBus.emit_on_sfx_volume_set(value)
