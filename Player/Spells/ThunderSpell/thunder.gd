extends CharacterBody2D
class_name Thunder

@export_group("Upgradable Stats")
@export var anim_speed: float = 1
@export var attack_damage: float = 2
@export var knockback_force: float = 0
@export var max_pierce := 1

@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var audioStreamPlayer: AudioStreamPlayer2D = $ThunderSpellSong
@onready var animPlayer: AnimationPlayer = $AnimationPlayer

var inrange := false
var initial_anim_player_speed = 1
var current_enemy

func _ready():
	audioStreamPlayer.play()
	animPlayer.set_speed_scale(anim_speed/100)
	animPlayer.play("attack")
	
func _physics_process(_delta):
	pass
		
func _on_hitbox_component_body_entered(body):
	if body is Enemy:
		current_enemy = body
		inrange = true

func _on_hitbox_component_body_exited(body):
	if body is Enemy:
		current_enemy = null
		inrange = false

func on_enemy_hit():
	pass
	
func damaging():
	if inrange:
		var hitbox: HitboxComponent = current_enemy.get_node("HitboxComponent")
		
		var attack = Attack.new()
		attack.attack_damage = attack_damage + player.attack_damage
		attack.knockback_force = knockback_force
		attack.attack_position = global_position
		attack.stun_time = 0
		
		hitbox.damage(attack)
		on_enemy_hit()
