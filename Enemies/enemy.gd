extends CharacterBody2D
class_name Enemy

@export_group("Stat Values")
@export var movemement_speed: float = 40.0
@export var health: float = 20.0
@export var enemy_damage: float = 1.0
@export var attack_speed: float = 0.5
@export var knockback_recovery: float = 3.0
@export var armor: float = 2.0
@export var min_experience: int = 0
@export var max_experience: int = 5
@export_enum("base", "elite", "boss") var enemy_type: String

@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var enemySprite2D: Sprite2D = $Sprite2D

var exp_gem: PackedScene = preload("res://Objects/experience_gem.tscn")
@onready var experienceGem: Node2D = get_tree().get_first_node_in_group("experience")
var chest_loot: PackedScene = preload("res://Objects/chest_loot.tscn")
@onready var chestLoot: Node2D = get_tree().get_first_node_in_group("chest")

var alive := true
var idle := true
var walk := false
var inrange := false
var attacking := false
var hurt := false
var stunned := false

func _ready():
	pass
	
func _on_hitbox_component_body_entered(body):
	if body is Player:
		inrange = true
		attacking = true

func _on_hitbox_component_body_exited(body):
	if body is Player:
		inrange = false

func spawnExperience():
	var new_gem = exp_gem.instantiate()
	new_gem.global_position = global_position
	new_gem.experience = randi_range(min_experience, max_experience)
	experienceGem.call_deferred('add_child', new_gem)
	
func spawnLoot():
	var value = [1, 2].pick_random() 
	if enemy_type != "base" and value == 2:
		var new_loot = chest_loot.instantiate()
		new_loot.global_position = global_position
		chestLoot.call_deferred('add_child', new_loot)

func on_player_hit():
	pass
	
func damaging():
	if inrange:
		var hitbox: HitboxComponent = player.get_node("HitboxComponent")
		
		var attack = Attack.new()
		attack.attack_damage = enemy_damage
		attack.knockback_force = 0
		attack.attack_position = global_position
		attack.stun_time = 0
		
		hitbox.damage(attack)
		on_player_hit()
	else:
		attacking = false
