extends CharacterBody2D
class_name Boss

@export_group("Base Stat")
var movemement_speed: float = 200.0
var health: float = 1000
var enemy_damage: float = 30
var beam_damage: float = 50
var attack_speed: float = 0.5
var knockback_recovery: float = 3.0
var armor: float = 200
var min_experience: int = 150
var max_experience: int = 150
var elemental_type: String
var type_resistant: String
var type_effective: String
var enemy_type: String
var enemySpritePath: String

@export_group("Stat Multiplicator")
var increase_movement_speed: float = 100
var increase_health: float = 100
var increase_enemy_damage: float = 100
var increase_attack_speed: float = 100
var increase_knockback_recovery: float = 100
var increase_armor: float = 100

@onready var elemental_animation_player = $ElementalAnimationPlayer
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var animation_tree = $AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]
@onready var animation_player = $AnimationPlayer
@onready var health_component = $HealthComponent


var rangeAttackNode: PackedScene = preload("res://Enemies/Boss/RangedAttack.tscn")
var exp_gem: PackedScene = preload("res://Objects/experience_gem.tscn")
@onready var experienceGem: Node2D = get_tree().get_first_node_in_group("experience")
var chest_loot: PackedScene = preload("res://Objects/chest_loot.tscn")
@onready var chestLoot: Node2D = get_tree().get_first_node_in_group("chest")
var chest_support_loot: PackedScene = preload("res://Objects/support_loot.tscn")

const melee_attacks = ["melee_attack", "defense"]
const range_attacks = ["hurt", "range_attack"]
var distance_to = 800
var to_go: Vector2 = Vector2.RIGHT
var facing_left: bool

var can_attack := true
var alive := true
var inrange := false
var attacking := false
var defense := false
var hurt := false

func _ready():
	$CanvasLayer/TextureProgressBar.max_value = health_component.MAX_HEALTH
	$CanvasLayer/TextureProgressBar.value = health_component.MAX_HEALTH
	state_machine.travel("range_attack")
	
func _physics_process(_delta):
	if !alive:
		state_machine.travel("death")
	$CanvasLayer/TextureProgressBar.value =  health_component.health
	facing_left = player.global_position.x > global_position.x
	if not facing_left:
		$Sprite2D.flip_h = true
		$HitboxComponent/CollisionShape2D.scale.x = -1
		$Beam.position = Vector2(-120, -14)
		$Beam/Sprite2D.flip_h = true
		$Beam/CollisionShape2D.scale.x = -1
	else:
		$Sprite2D.flip_h = false
		$HitboxComponent/CollisionShape2D.scale.x = 1
		$Beam.position = Vector2(100, -14)
		$Beam/Sprite2D.flip_h = false
		$Beam/CollisionShape2D.scale.x = 1
		
	if state_machine.get_current_node() == "walk":
		var direction = global_position.direction_to(to_go)
		velocity = direction * movemement_speed
		move_and_slide()
	
func melee_attack():
	moove()
	var current_melee_attack = melee_attacks.pick_random()
	if(current_melee_attack == "melee_attack" and distance_to > 30):
		current_melee_attack = "walk"
	state_machine.travel(current_melee_attack)

func range_attack():
	await get_tree().create_timer(0.2).timeout
	moove()
	var current_range_attack
	if(distance_to > 30):
		var chance = randf()
		if chance < 0.4:
			current_range_attack = "hurt"
		else:
			current_range_attack = "range_attack"
	else:
		current_range_attack = "melee_attack"
	state_machine.travel(current_range_attack)
	
func can_do_defense_buff():
	var chance = randf()
	animation_tree["parameters/conditions/can_buff"] = chance < 0.6
	
func moove():
	distance_to = global_position.distance_to(player.global_position)
	var random = randi_range(1,4)
	if  distance_to > 30 :
		match(random):
			1:
				to_go = Vector2(player.global_position.x - 10, player.global_position.y - 10)
			2:
				to_go = Vector2(player.global_position.x - 10, player.global_position.y + 10)
			3:
				to_go = Vector2(player.global_position.x + 10, player.global_position.y - 10)
			4:
				to_go = Vector2(player.global_position.x + 10, player.global_position.y + 10)
				
		to_go = Vector2(player.global_position.x - 10, player.global_position.y)
	else:
		match(random):
			1:
				to_go = Vector2(player.global_position.x - 200, player.global_position.y - 200)
			2:
				to_go = Vector2(player.global_position.x - 200, player.global_position.y + 200)
			3:
				to_go = Vector2(player.global_position.x + 200, player.global_position.y - 200)
			4:
				to_go = Vector2(player.global_position.x + 200, player.global_position.y + 200)

func armor_buff():
	armor += 10
	
func instantiate_beam():
	$Beam/Sprite2D.frame = 0
	$Beam/CollisionShape2D.disabled = false
	$Beam.visible = true
	$Beam/AnimationPlayer.play("beam")
	
func hide_beam():
	$Beam.visible = false
	$Beam/CollisionShape2D.disabled = true
	
func instantiate_attacking_range():
	var current_range_attack = rangeAttackNode.instantiate()
	current_range_attack.attack_speed = attack_speed
	current_range_attack.increase_attack_speed = increase_attack_speed
	current_range_attack.elemental_type = elemental_type
	current_range_attack.enemy_damage = enemy_damage
	self.add_child(current_range_attack)
	
func return_damage():
	if defense:
		defense = false
	else:
		defense = true
	
				
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
	var value = [1, 2, 3, 4].pick_random() 
	if value == 2:
		var new_loot = chest_loot.instantiate()
		new_loot.global_position = global_position
		chestLoot.call_deferred('add_child', new_loot)
	if value == 3:
		var new_loot = chest_support_loot.instantiate()
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
		on_player_hit()
	else:
		attacking = false

func _on_beam_body_entered(body):
	if body is Player and can_attack:
		can_attack = false
		var hitbox: HitboxComponent = player.get_node("HitboxComponent")
		var attack = Attack.new()
		attack.elemental_modifier = 0.5
		attack.can_crit = false
		attack.knockback_force = 0
		attack.stun_time = 0
		attack.attack_position = global_position
		attack.target = player
		attack.attacker = self		
		var effective_damage = attack.calculate_effective_damage(elemental_type, beam_damage)
		attack.effective_damage = effective_damage
		hitbox.damage(attack)
		on_player_hit()
		await get_tree().create_timer(1).timeout
		can_attack = true
