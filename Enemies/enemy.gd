extends CharacterBody2D
class_name Enemy

var movemement_speed: float = 40.0
var health: float = 20.0
var enemy_damage: float = 1.0
var attack_speed: float = 0.5
var knockback_recovery: float = 3.0
var armor: float = 200
var min_experience: int = 0
var max_experience: int = 5
var elemental_type: String
var type_resistant: String
var type_effective: String
var enemy_type: String
var enemySpritePath: String

@onready var elemental_animation_player = $ElementalAnimationPlayer


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
	enemySprite2D.texture = load(enemySpritePath)
	var scaling_vector: Vector2
	match(enemy_type):
		"base":
			scaling_vector = Vector2(1, 1)
		"elite":
			scaling_vector = Vector2(2, 2)
			enemySprite2D.self_modulate = Color(0.964, 0.948, 0)
		"boss":
			scaling_vector = Vector2(5, 5)
			enemySprite2D.self_modulate = Color(0.257, 0.645, 1)
	self.scale = scaling_vector
	
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
	match(enemy_type):
		"base":
			pass
		"elite":
			var value = [1, 2, 3, 4].pick_random() 
			if value == 2:
				var new_loot = chest_loot.instantiate()
				new_loot.global_position = global_position
				chestLoot.call_deferred('add_child', new_loot)
		"boss":
			var new_loot = chest_loot.instantiate()
			new_loot.global_position = global_position
			chestLoot.call_deferred('add_child', new_loot)

func on_player_hit():
	pass
	
func damaging():
	if inrange:
		var hitbox: HitboxComponent = player.get_node("HitboxComponent")
		
		var attack = Attack.new()
		attack.elemental_modifier = 0.5
		attack.can_crit = false
		attack.knockback_force = 0
		attack.stun_time = 0
		attack.attack_position = global_position
		attack.target = player
		attack.attacker = self		
		var effective_damage = attack.calculate_effective_damage(elemental_type, enemy_damage)
		attack.effective_damage = effective_damage
		hitbox.damage(attack)
		
		#var attack = Attack.new()
		#attack.attack_damage = enemy_damage
		#attack.knockback_force = 0
		#attack.attack_position = global_position
		#attack.stun_time = 0
		on_player_hit()
	else:
		attacking = false
