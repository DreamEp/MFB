extends Area2D
class_name Chest

@export var loot = 1 

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var audioStreamPlayer: AudioStreamPlayer2D = $PickupChestSong

var target = null
var speed = -0.5 

func _ready():
	pass

func _physics_process(delta):
	if target != null: 
		global_position = global_position.move_toward(target.global_position, speed) 
		speed += 2 * delta 

func collect():
	audioStreamPlayer.play() 
	#audioStreamPlayer.connect("finished", Callable(self, "_on_snd_collected_finished"))
	audioStreamPlayer.finished.connect(_on_snd_collected_finished)
	#collision.call_deferred("set","disabled",true)
	collision.set_deferred("disabled", true)
	sprite.visible = false
	return loot


func _on_snd_collected_finished():
	queue_free()


#func _on_pickup_chest_song_finished():
	#queue_free()
