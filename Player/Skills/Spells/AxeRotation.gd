extends Skill
class_name AxeRotation

@export_group("Projectile Stat")
#@export_enum("linear_shot","rain","rotative", "crescent") var projectile_physics: String
@export var projectile_speed: float
@export var attack_damage: float
@export var knockback_force: float
@export_enum("Physical","Electric","Fire","Ice","Poison") var elemental_type: String
@export_enum("Arrow","Axe") var projectile_type: String

@export_group("Skill Stats")
@export var coldown: float
@export var duration: float
@export var projectile_count: int
@export var radius: int
@export var support_skills: Array[SupportSkill]


var player: Player
var PROJ_PATH: String = "res://Art/Player/Projectiles/"
var projectileNode: PackedScene = preload("res://Player/Projectiles/projectile.tscn")
var can_fire = true
var projectile_physics: String = "rotative"

func cast(current_angle, current_radius, playerNode, tree):
	var texture_path:= "%s%ss/%s.png" % [PROJ_PATH, projectile_type, elemental_type+"_"+projectile_type]
	var texture = load(texture_path)
	var projectile = projectileNode.instantiate()
	
	projectile.duration = duration
	projectile.radius = current_radius
	projectile.projectile_speed = projectile_speed 
	projectile.attack_damage = attack_damage
	projectile.elemental_type = elemental_type
	projectile.projectile_physics = projectile_physics
	projectile.max_pierce = -1

	projectile.rotation = current_angle
	projectile.current_rotation = current_angle
	projectile.position = Vector2(
					playerNode.global_position.x + current_radius * cos(deg_to_rad(current_angle)),
					playerNode.global_position.y + current_radius * sin(deg_to_rad(current_angle))
				)
	
	projectile.find_child("Sprite2D").texture = texture
	tree.root.call_deferred("add_child", projectile)
	
func axe_rotation(tree, current_coldown, current_projectile_count):
	if can_fire:
		can_fire = false
		for i in range(current_projectile_count):
			var current_angle = i * (360 / current_projectile_count) 
			cast(current_angle, radius, player, tree)
		await tree.create_timer(current_coldown + duration + (player.spell_duration * player.increase_spell_duration/100)).timeout
		can_fire = true

func activate(_mouse_position, tree):
	player = tree.get_first_node_in_group("player")
	var current_projectile_count = projectile_count + player.additional_spell_projectile
	var current_coldown = coldown - (player.spell_coldown * player.increase_spell_coldown/100)
	axe_rotation(tree, current_coldown, current_projectile_count)
