extends Skill
class_name AxeRotation

@export_group("Projectile Stat")
#@export_enum("linear_shot","rain","rotative", "crescent") var projectile_physics: String
@export var projectile_speed: float
@export var attack_damage: float
@export var knockback_force: float
@export var stun_time: float
@export_enum("Physical","Electric","Fire","Ice","Poison") var elemental_type: String
@export_enum("Arrow","Axe") var projectile_type: String

@export_group("Skill Stats")
@export var coldown: float
@export var duration: float
@export var projectile_count: int
@export var radius: int


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
	projectile.stun_time = stun_time
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
	
func axe_rotation(tree):
	player = tree.get_first_node_in_group("player")
	projectile_count += player.additional_attack_proctile
	coldown = coldown #- (coldown * (player.attack_speed/100))
	if can_fire:
		can_fire = false
		for i in range(projectile_count):
			var current_angle = i * (360 / projectile_count)
			cast(current_angle, radius, player, tree)
		await tree.create_timer(coldown+duration).timeout
		can_fire = true

func activate(_mouse_position, tree):
	axe_rotation(tree)
