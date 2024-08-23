extends Skill
class_name ArrowsShot

@export_group("Projectile Stat")
#@export_enum("linear_shot","rain", "rotative","crescent") var projectile_physics: String
@export var projectile_speed: float
@export var shooting_range: float
@export var attack_damage: float
@export var knockback_force: float
@export var max_pierce: int
@export var stun_time: float
@export_enum("Physical","Electric","Fire","Ice","Poison") var elemental_type: String
@export_enum("Arrow","Axe") var projectile_type: String

@export_group("Skill Stats")
@export var coldown: float
@export var cast_count: int
@export var coldown_between_salve: float
@export var projectile_count: int
@export var space_between_projectiles: int


var player: Player
var PROJ_PATH: String = "res://Art/Player/Projectiles/"
var projectileNode: PackedScene = preload("res://Player/Projectiles/projectile.tscn")
var firing_position : Marker2D
var can_fire = true
var projectile_physics: String = "linear_shot"


func cast(arc_rad, increment, counter, mouse_direction, tree):
	var texture_path:= "%s%ss/%s.png" % [PROJ_PATH, projectile_type, elemental_type+"_"+projectile_type]
	var texture = load(texture_path)
	var projectile = projectileNode.instantiate()
	
	projectile.position = firing_position.global_position
	projectile.projectile_speed = projectile_speed
	projectile.shooting_range = shooting_range
	projectile.attack_damage = attack_damage
	projectile.max_pierce = max_pierce
	projectile.stun_time = stun_time
	projectile.elemental_type = elemental_type
	projectile.projectile_physics = projectile_physics
	
	if arc_rad != null:
		projectile.global_rotation = (
					mouse_direction.angle() +
					increment * counter -
					arc_rad / 2
				)
	else:
		projectile.rotation = mouse_direction.angle()
	
	projectile.find_child("Sprite2D").texture = texture
	tree.root.call_deferred("add_child", projectile)
	#tree.current_scene.add_child(projectile)
	
func arrows_shot(mouse_position, tree, current_projectile_count):
	firing_position = player.get_node("PlayerAttacks").get_node("AttacksPivot").get_node("Bow").get_node("ArrowFirePosition")
	if can_fire:
		can_fire = false
		var mouse_direction = mouse_position - firing_position.global_position
		for j in range(cast_count):
			for i in range(current_projectile_count):
				if projectile_count == 1:
					cast(null, null, null, mouse_position, tree)
				else:
					var arc_rad = deg_to_rad(space_between_projectiles + ((space_between_projectiles * current_projectile_count)/current_projectile_count))
					var increment = arc_rad / (current_projectile_count - 1)
					cast(arc_rad, increment, i, mouse_direction, tree)
			await tree.create_timer(coldown_between_salve).timeout
		await tree.create_timer(coldown).timeout
		can_fire = true

func activate(mouse_position, tree):
	player = tree.get_first_node_in_group("player")
	var current_projectile_count = projectile_count + player.additional_attack_projectile
	arrows_shot(mouse_position, tree, current_projectile_count)
