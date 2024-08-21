extends Area2D
class_name Projectile

var projectile_speed: float
var shooting_range: float
var attack_damage: float
var knockback_force: float
var max_pierce : int
var stun_time: float
var elemental_type: String

@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D

var current_pierce_count:int = 0
var travalled_distance:float = 0
var direction: Vector2
var angle_rotation: float

func _ready():
	sprite.rotate(angle_rotation)

func _physics_process(delta):
	position += projectile_speed * direction * delta
	travalled_distance += projectile_speed * delta
	#var collision = move_and_collide(velocity)
	#if collision:
		#if collision.get_collider().get_class() == "TileMap":
			#queue_free()
	if travalled_distance > shooting_range:
		queue_free()

func on_enemy_hit():
	current_pierce_count += 1
	if current_pierce_count >= max_pierce:
		queue_free()
	
func _on_screen_exited():
	queue_free()

func _on_body_entered(body):
	if body is Enemy:
		var hitbox: HitboxComponent = body.get_node("HitboxComponent")
		
		var attack = Attack.new()
		attack.elemental_modifier = 0.5
		attack.can_crit = true
		attack.knockback_force = knockback_force + player.knockback_force
		attack.stun_time = stun_time
		attack.attack_position = global_position
		attack.target = body
		attack.attacker = player		
		attack_damage += player.attack_damage
		var effective_damage = attack.calculate_effective_damage(elemental_type, attack_damage)
		attack.effective_damage = effective_damage
		
		hitbox.damage(attack)
		on_enemy_hit()	
