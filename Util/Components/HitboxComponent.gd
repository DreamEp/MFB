extends Area2D
class_name HitboxComponent

@export var health_component : HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
func damage(attack: Attack):
	if health_component:
		health_component.damage(attack)
