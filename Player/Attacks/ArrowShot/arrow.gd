extends CharacterBody2D
class_name Arrow

@export_group("Upgradable Stats")
@export var speed: float = 150
@export var shooting_range: float = 150
@export var attack_damage: float = 2
@export var knockback_force: float = 0
@export var max_pierce := 1
@export var stun_time := 1
@export_enum("none","physical","fire","electric") var elemental_type: String

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
	if travalled_distance > shooting_range:
		queue_free()

func on_enemy_hit():
	current_pierce_count += 1
	if current_pierce_count >= max_pierce:
		queue_free()
		
func _on_hitbox_component_body_entered(body):
	if body is Enemy:
		var hitbox: HitboxComponent = body.get_node("HitboxComponent")
		
		var attack = Attack.new()
		attack.elemental_modifier = 0.5
		attack.can_crit = true
		attack.knockback_force = knockback_force + player.knockback_force
		attack.stun_time = stun_time
		attack.attack_position = global_position
		attack.target = body
		attack.attacker = player		
		attack_damage += player.attack_damage
		var effective_damage = attack.calculate_effective_damage(elemental_type, attack_damage)
		attack.effective_damage = effective_damage
		
		hitbox.damage(attack)
		on_enemy_hit()	
