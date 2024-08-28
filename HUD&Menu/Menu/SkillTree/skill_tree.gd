extends Control

@onready var exit = $Exit
@onready var mainMenuContainer: NinePatchRect = $"../NinePatchRect"

func _ready():
	pass


func _on_exit_pressed():
	self.visible = false
	mainMenuContainer.visible = true
	SignalBus.emit_set_passive_tree_array(PassiveTreeDataContainer.create_storage_passive_skill())
