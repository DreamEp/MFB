extends Skill
class_name CrescentStrike

@export_group("Projectile Stat")
#@export_enum("linear_shot","rain", "rotative", "crescent") var projectile_physics: String
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
#@export var space_between_projectiles: int
@export var distance: Array[float]
@export var angle: Array[float]
@export var can_return: Array[bool]


var player: Player
var PROJ_PATH: String = "res://Art/Player/Projectiles/"
var projectileNode: PackedScene = preload("res://Player/Projectiles/projectile.tscn")
var firing_position : Marker2D
var can_fire = true
var projectile_physics: String = "crescent"

func cast(current_distance, current_angle, current_can_return, playerNode, mouse_position, tree):
	var texture_path:= "%s%ss/%s.png" % [PROJ_PATH, projectile_type, elemental_type+"_"+projectile_type]
	var texture = load(texture_path)
	var projectile = projectileNode.instantiate()
	
	projectile.position = playerNode.global_position
	
	projectile.set_deviation(current_distance,current_angle)
	projectile.set_can_return(current_can_return)
	projectile.set_destination(mouse_position, playerNode.global_position)
	
	projectile.angle_rotation = mouse_position.angle()
	projectile.projectile_speed = projectile_speed
	projectile.attack_damage = attack_damage
	projectile.max_pierce = max_pierce
	projectile.stun_time = stun_time
	projectile.elemental_type = elemental_type
	projectile.projectile_physics = projectile_physics
	
	projectile.find_child("Sprite2D").texture = texture
	
	tree.current_scene.add_child(projectile)
	
func crescent_strike(mouse_position, tree, current_projectile_count):
	if can_fire:
		can_fire = false
		for j in range(cast_count):
			for i in range(current_projectile_count):
				var current_distance
				var current_angle 
				var current_can_return
				if i < self.distance.size():
					current_distance = self.distance[i]
					current_angle = self.angle[i]
					current_can_return = self.can_return[i]
				else:
					current_distance = self.distance[i%2]
					current_angle = self.angle[i%2]
					current_can_return = self.can_return[i%2]
				#mouse
				cast(current_distance, current_angle, current_can_return, player, mouse_position, tree)
			await tree.create_timer(coldown_between_salve).timeout
		await tree.create_timer(coldown).timeout
		can_fire = true
		
func activate(mouse_position, tree):
	player = tree.get_first_node_in_group("player")
	var current_projectile_count = projectile_count + player.additional_attack_projectile
	crescent_strike(mouse_position, tree, current_projectile_count)
