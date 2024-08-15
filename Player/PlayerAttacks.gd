extends Area2D

@onready var player: Player = get_owner()
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")

@onready var arrowsShot = $ArrowsShot
@onready var axeCircle = $AxeCircle
@onready var thunderSpell = $ThunderSpell


@onready var settings_resource: DefaultSettingsResource = preload("res://Resources/Settings/DefaultSettings.tres")

var enemy_position: Vector2

func _ready():
	pass

func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies()
	axeCircle.spawnAxeCircle()
	thunderSpell.spawnThunderSpell(enemies_in_range)
	if(!settings_resource.auto_aim_state):
		enemy_position = get_global_mouse_position()
		look_at(enemy_position)
	else:
		if enemies_in_range.size() > 0:
			var closest_enemy = enemies_in_range.front()
			for current_enemy in enemies_in_range:
				if(current_enemy.global_position.distance_to(player.global_position) < closest_enemy.global_position.distance_to(player.global_position)):
					closest_enemy = current_enemy
			enemy_position = closest_enemy.global_position
			look_at(enemy_position)
			
	if(settings_resource.auto_attacks_state):
		arrowsShot.spawnArrowShot(enemy_position)
	else:
		if Input.is_action_just_pressed("left_click"):
			arrowsShot.spawnArrowShot(enemy_position)
	
