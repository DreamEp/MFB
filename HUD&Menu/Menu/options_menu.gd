extends Control
class_name OptionMenu

@onready var mainMenuContainer: MarginContainer = $"../MarginContainer"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_exit_pressed():
	self.visible = false
	mainMenuContainer.visible = true
