extends Skill
class_name RainOfArrows

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
@export var cast_count: int
@export var coldown_between_salve: float
@export var projectile_count: int
@export var space_between_projectiles: int
@export var coldown: float

var player: Player
var PROJ_PATH: String = "res://Art/Player/Projectiles/"
var projectileNode: PackedScene = preload("res://Player/Projectiles/projectile.tscn")
var can_fire = true
var projectile_physics: String = "rain"


func cast(mouse_position, tree, separation):
	#res://Art/Player/Projectiles/Arrows/Physical_Arrow.png"
	#res://Art/Player/Projectiles/Arrows/Arrow_physical.png
	var texture_path:= "%s%ss/%s.png" % [PROJ_PATH, projectile_type, elemental_type+"_"+projectile_type]
	var texture = load(texture_path)
	var middle: int = (space_between_projectiles*projectile_count)/2
	var projectile = projectileNode.instantiate()
	
	projectile.angle_rotation = -80
	projectile.direction = Vector2(0, 1)
	projectile.position = mouse_position + separation - Vector2(middle, 60)
	projectile.projectile_speed = projectile_speed
	projectile.shooting_range = shooting_range
	projectile.attack_damage = attack_damage
	projectile.max_pierce = max_pierce
	projectile.stun_time = stun_time
	projectile.elemental_type = elemental_type
	projectile.projectile_physics = projectile_physics
	
	projectile.find_child("Sprite2D").texture = texture
	
	tree.current_scene.add_child(projectile)
	
func rain_down(mouse_position, tree, current_projectile_count):
	if can_fire:
		can_fire = false
		for j in range(cast_count):
			for i in range(current_projectile_count):
				cast(mouse_position, tree, Vector2(i*space_between_projectiles, 0))
			await tree.create_timer(coldown_between_salve).timeout
		await tree.create_timer(coldown).timeout
		can_fire = true
		
func activate(mouse_position, tree):
	player = tree.get_first_node_in_group("player")
	var current_projectile_count = projectile_count + player.additional_spell_projectile
	rain_down(mouse_position, tree, current_projectile_count)
