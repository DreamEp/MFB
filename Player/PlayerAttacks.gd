extends Area2D

@onready var player: Player = get_owner()
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
@export var firing_position : Marker2D

var axeShot_scene: PackedScene = preload("res://Objects/Attacks/axe.tscn")
#@onready var axeShot: AxeShot = $AxeShot


var arrowShot_scene: PackedScene = preload("res://Objects/Attacks/arrow_shot.tscn")
@onready var initialArrowShot: ArrowShot = arrowShot_scene.instantiate()

#@onready var spriteBow = $FiringPosition/Bow
@onready var settings_resource: DefaultSettingsResource = preload("res://Resources/Settings/DefaultSettings.tres")

var enemy_position: Vector2

func _ready():
	await get_tree().create_timer(initialArrowShot.base_bow_rate).timeout
	initialArrowShot.can_bow_attack = true

func _physics_process(_delta):
	if(!settings_resource.auto_aim_state):
		enemy_position = get_global_mouse_position()
		look_at(enemy_position)
	else:
		var enemies_in_range = get_overlapping_bodies()
		if enemies_in_range.size() > 0:
			var target_enemy = enemies_in_range.front()
			enemy_position = target_enemy.global_position
			look_at(enemy_position)
			
	if(settings_resource.auto_attacks_state):
		spawnArrowShot()
	else:
		if Input.is_action_just_pressed("left_click"):
			spawnArrowShot()
					
func spawnArrowShot():
	var arrow_count = initialArrowShot.base_arrow_count + player.additional_spell_proctile + player.additional_attack_proctile
	var bow_rate = initialArrowShot.base_bow_rate - (initialArrowShot.base_bow_rate * (player.attack_coldown/100))
	if initialArrowShot.can_bow_attack:
		initialArrowShot.can_bow_attack = false
		var mouse_direction = enemy_position - firing_position.global_position
		for i in arrow_count:
			var spawned_arrow = arrowShot_scene.instantiate()
			spawned_arrow.position = firing_position.global_position
			
			if arrow_count == 1:
				spawned_arrow.rotation = mouse_direction.angle()
			else:
				var arc_rad = deg_to_rad(spawned_arrow.arc_range + ((spawned_arrow.arc_range * arrow_count)/arrow_count))
				var increment = arc_rad / (arrow_count - 1)
				spawned_arrow.global_rotation = (
					mouse_direction.angle() +
					increment * i -
					arc_rad / 2
				)
			get_tree().root.call_deferred("add_child",spawned_arrow)
		await get_tree().create_timer(bow_rate).timeout
		initialArrowShot.can_bow_attack = true
		
func spawnAxeShot():
	var spawned_axe := axeShot_scene.instantiate()
	get_tree().root.add_child(spawned_axe)
	if is_instance_valid(enemy):
		spawned_axe.global_position = player.global_position
		spawned_axe.rotation = enemy.global_position.angle()
	else:
		spawned_axe.global_position = player.global_position
		spawned_axe.target = enemy_position
	
	##################################################
	# Strategy Relevant Code:
	# Here, we loop over all of the upgrades currently
	# on the player, and apply their upgrade to the
	# spawned axe.
	##################################################
	#for strategy in player.upgrades:
		#strategy.apply_upgrade(spawned_axe)
	
