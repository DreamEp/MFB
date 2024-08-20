extends CharacterBody2D
class_name Axe

@export_group("Upgradable Stats")
@export var speed := 150.0
@export var attack_damage := 5.0
@export var knockback_force := 2
@export var stun_time := 1
@export var axe_duration := 3
@export_enum("none","physical","fire","electric") var elemental_type: String

@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var sprite: Sprite2D = $Sprite2D
@onready var audioStreamPlayer: AudioStreamPlayer2D = $AxeAttackSong
@onready var maxTimer = $MaxTimer
@onready var player_position: Marker2D = player.get_node("PlayerPosition")

var axe_kill = false
var current_rotation
var axe_circle_radius


func _ready():
	maxTimer.wait_time = axe_duration + player.spell_duration
	maxTimer.start()
	
func _physics_process(delta: float) -> void:
	current_rotation += delta * speed * PI
	var x = player_position.global_position.x + axe_circle_radius * cos(deg_to_rad(current_rotation))
	var y = player_position.global_position.y + axe_circle_radius * sin(deg_to_rad(current_rotation))
	position =  Vector2(x, y)
	move_and_slide()

func on_enemy_hit():
	pass

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


func _on_max_timer_timeout():
	queue_free()
