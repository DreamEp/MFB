extends Skill
class_name RainOfArrows

@export_group("Projectile Stat")
@export var projectile_speed: float
@export var shooting_range: float
@export var attack_damage: float
@export var knockback_force: float
@export var max_pierce: int
@export var stun_time: float
@export_enum("physical","electric","fire","ice","poison") var elemental_type: String
@export_enum("Base_Arrow","Electric_Arrow","Fire_Arrow","Ice_Arrow","Poison_Arrow") var type_arrow: String

@export_group("Skill Stats")
@export var cast_count: int
@export var coldown_between_salve: float
@export var projectile_count: int
@export var space_between_arrows: int
@export var coldown: float


var ARROW_PATH: String = "res://Art/Player/Projectiles/Arrows/"
var projectileNode: PackedScene = preload("res://Player/Projectiles/projectile.tscn")
var can_fire = true


func cast(mouse_position, tree, separation):
	var texture_path:= "%s.png" % (ARROW_PATH + type_arrow)
	var texture = load(texture_path)
	var middle: int = (space_between_arrows*projectile_count)/2
	var projectile = projectileNode.instantiate()
	
	projectile.angle_rotation = -80
	projectile.direction = Vector2(0, 1)
	projectile.position = mouse_position + separation - Vector2(middle, 60)
	projectile.projectile_speed = projectile_speed
	projectile.shooting_range = shooting_range
	projectile.attack_damage = attack_damage
	projectile.max_pierce = max_pierce
	projectile.stun_time = stun_time
	projectile.elemental_type = "physical"
	
	projectile.find_child("Sprite2D").texture = texture
	
	tree.current_scene.add_child(projectile)
	
func rain_down(mouse_position, tree):
	if can_fire:
		can_fire = false
		for j in range(cast_count):
			for i in range(projectile_count):
				cast(mouse_position, tree, Vector2(i*space_between_arrows, 0))
			await tree.create_timer(coldown_between_salve).timeout
		await tree.create_timer(coldown).timeout
		can_fire = true
		
func activate(mouse_position, tree):
	rain_down(mouse_position, tree)
