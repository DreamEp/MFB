extends CharacterBody2D
class_name Arrow

@export_group("Upgradable Stats")
@export var speed: float = 150
@export var range: float = 150
@export var attack_damage: float = 2
@export var knockback_force: float = 0
@export var max_pierce := 1

@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var audioStreamPlayer: AudioStreamPlayer2D = $ArrowAttackSong

var current_pierce_count := 0
var direction: Vector2
var travalled_distance = 0

func _ready():
	audioStreamPlayer.play()
	
func _physics_process(delta):
	direction = Vector2.RIGHT.rotated(global_rotation)
	velocity = direction * speed * delta
	travalled_distance += speed * delta
	var collision = move_and_collide(velocity)
	if collision:
		if collision.get_collider().get_class() == "TileMap":
			queue_free()
	if travalled_distance > range:
		queue_free()

func on_enemy_hit():
	current_pierce_count += 1
	if current_pierce_count >= max_pierce:
		queue_free()
		
func _on_hitbox_component_body_entered(body):
	if body is Enemy:
		var hitbox: HitboxComponent = body.get_node("HitboxComponent")
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage + player.attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		
		hitbox.damage(attack)
		on_enemy_hit()	
