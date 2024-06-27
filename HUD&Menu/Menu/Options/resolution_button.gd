extends Control

@onready var optionButton: OptionButton = $HBoxContainer/OptionButton

const RESOLUTION_DICTIONARY: Dictionary = {
	"640x360" : Vector2i(640, 360),
	"1280x720" : Vector2i(1280, 720),
	"1920x1080" : Vector2i(1920, 1080)
}
# Called when the node enters the scene tree for the first time.
func _ready():
	add_resolution_items()

func add_resolution_items():
	for resolution_size_text in RESOLUTION_DICTIONARY:
		optionButton.add_item(resolution_size_text)

func _on_option_button_item_selected(index):
	DisplayServer.window_set_size(RESOLUTION_DICTIONARY.values()[index])
