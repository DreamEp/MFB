extends Area2D
class_name Projectile

var projectile_speed: float
var shooting_range: float
var attack_damage: float
var knockback_force: float
var max_pierce: int
var max_chain: int
var stun_time: float
var elemental_type: String
var projectile_physics: String
#Crescent
var can_return: bool = false
var deviation_distance: float = 120
var deviation_angle: float = 60
#Axe circle
var duration: float
var radius: float
var current_rotation: float

var p0 : Vector2
var p1 : Vector2
var p2 : Vector2
var returning : bool = false
var t : float = 0.0

@onready var enemy: Enemy = get_tree().get_first_node_in_group("enemy")
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D
@onready var timerDuration = $TimerDuration

var current_pierce_count:int = 0
var travalled_distance:float = 0
var direction: Vector2
var angle_rotation: float

func _ready():
	projectile_speed += player.projectile_speed * player.increase_projectile_speed / 100
	match(projectile_physics):
		"rain":
			sprite.rotate(angle_rotation)
		"rotative":
			timerDuration.wait_time = duration + (player.spell_duration * player.increase_spell_duration / 100)
			timerDuration.start()
		"crescent":
			sprite.rotate(angle_rotation)
			set_physics_process(false)

func _physics_process(delta):
	match(projectile_physics):
		"linear_shot":
			direction = Vector2.RIGHT.rotated(global_rotation)
			position += direction * projectile_speed * delta
			travalled_distance += projectile_speed * delta
			if travalled_distance > shooting_range:
				queue_free()
		"rain":
			position += projectile_speed * direction * delta
			travalled_distance += projectile_speed * delta
			if travalled_distance > shooting_range:
				queue_free()
		"rotative":
			current_rotation += delta * projectile_speed * PI
			var x = player.global_position.x + radius * cos(deg_to_rad(current_rotation))
			var y = player.global_position.y + radius * sin(deg_to_rad(current_rotation))
			position =  Vector2(x, y)
		"crescent":
			p0 = player.global_position
			if not returning:
				if t < 1.0:
					t += (projectile_speed/100) * delta
					if can_return and t >= 1.0:
						returning = true
					elif t>= 1.0:
						queue_free()
			else:
				if t >= 0:
					t -= (projectile_speed/100) * delta
					if t <= 0.0:
						queue_free()
			position = position.bezier_interpolate(p0,p1,p2,t)

func on_enemy_hit():
	current_pierce_count += 1
	if current_pierce_count >= max_pierce:
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
		
		if (max_pierce != -1):
			on_enemy_hit()	
			
#Crescent			
func set_destination(enemy_pos, player_pos):
	var final_destination: Vector2 = enemy_pos - player_pos
	var x = final_destination.x/sqrt(pow(final_destination.x, 2) + pow(final_destination.y, 2))
	var y = final_destination.y/sqrt(pow(final_destination.x, 2) + pow(final_destination.y, 2))
	final_destination = Vector2(x, y)  * shooting_range
	#final_destination = sqrt(pow(final_destination.x, 2) + pow(final_destination.y, 2)) * shooting_range
	p0 = player_pos
	p2 = final_destination #enemy_pos
 
	var tilted_unit_vector = (p2-p0).normalized().rotated(deg_to_rad(-deviation_angle))
	p1 = p0 + deviation_distance * tilted_unit_vector
	call_deferred("set_physics_process", true)
 
func set_deviation(distance, angle):
	deviation_distance = distance
	deviation_angle = angle
 
func set_can_return(value):
	can_return = value

#Queue free	
func _on_screen_exited():
	queue_free()
	
func _on_timer_duration_timeout():
	queue_free()
