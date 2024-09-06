extends Area2D
class_name Chest

@export var loot = 1 

@onready var sprite: Sprite2D = $Sprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var audioStreamPlayer: AudioStreamPlayer2D = $PickupChestSong
@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

var target = null
var speed = -0.5 

func _ready():
	pass

func _physics_process(delta):
	if target != null: 
		global_position = global_position.move_toward(target.global_position, speed) 
		speed += 2 * delta 

func collect():
	animationPlayer.play("opening")
	animationPlayer.animation_finished.connect(_on_animation_collected_finished)
	#audioStreamPlayer.connect("finished", Callable(self, "_on_snd_collected_finished"))

	#collision.call_deferred("set","disabled",true)
	collision.set_deferred("disabled", true)

	return loot


func _on_animation_collected_finished(_anim_name):
	audioStreamPlayer.play() 
	audioStreamPlayer.finished.connect(_on_snd_collected_finished)

func _on_snd_collected_finished():
	queue_free()


#func _on_pickup_chest_song_finished():
	#queue_free()


func _on_area_entered(area):
	if area is SupportLoot or area is Chest:
		self.position.x = [-10, 10].pick_random()
		self.position.y = [-10, 10].pick_random()
