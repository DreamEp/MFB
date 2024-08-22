extends Area2D

@onready var player: Player = get_owner()
@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")

@onready var thunderBolt = $ThunderBolt

@onready var settings_resource: DefaultSettingsResource = preload("res://Resources/Settings/DefaultSettings.tres")

var items: Array[Item]
var player_collected_skills
var enemy_position: Vector2

func _ready():
	pass

func _physics_process(_delta):
	items = player.items
	player_collected_skills = player.player_collected_skills
	var enemies_in_range = get_overlapping_bodies()
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
	for item in items:
		shoot_skills(enemy_position, item)
	#for attack_or_spell in player_collected_skills:
		#match attack_or_spell["displayname"]:
			#"Arrow Shot":
				#if(settings_resource.auto_attacks_state):
					#arrowShot.spawnArrowShot(enemy_position)
					#pass
				#else:
					#if Input.is_action_just_pressed("left_click"):
						#arrowShot.spawnArrowShot(enemy_position)
			#"Axe Circle":
				#axeCircle.spawnAxeCircle()
			#"Thunder Bolt":
				#thunderBolt.spawnThunderBolt(enemies_in_range)
			
	
func shoot_skills(mouse_position, current_item: Item = null):
	if current_item == null:
		return
	else:
		if current_item.skills != null:
			for skill in current_item.skills:
				if skill != null:
					skill.activate(mouse_position, get_tree())
