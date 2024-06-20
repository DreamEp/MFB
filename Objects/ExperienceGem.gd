extends Area2D
class_name Experience

@export var experience = 1 

var green_gem = preload("res://Art/Objects/gem_g.png") 
var blue_gem= preload("res://Art/Objects/gem_b.png") 
var red_gem = preload("res://Art/Objects/gem_r.png") 

var target = null
var speed = -0.5 

@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D
@onready var sound = $snd_collected 

func _ready():
	if experience < 5:
		return
	elif experience < 25:
		sprite.texture = blue_gem
	else:
		sprite.texture = red_gem 


func _physics_process(delta):
	if target != null: 
		global_position = global_position.move_toward(target.global_position, speed) 
		speed += 2 * delta 

func collect():
	sound.play() 
	sound.connect("finished", Callable(self, "_on_snd_collected_finished"))
	collision.call_deferred("set","disabled",true)
	sprite.visible = false
	return experience


func _on_snd_collected_finished():
	queue_free()
