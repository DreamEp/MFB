extends Area2D
class_name HurtboxComponent

func _on_body_entered(body):
	if body is HitboxComponent:
		var hitbox : HitboxComponent = body
		var attack = Attack.new()
		attack.attack_damage = hitbox.attack_damage
		attack.knockback_force = hitbox.knockback_force
		attack.attack_position = hitbox.global_position
		attack.stun_time = hitbox.stun_time
		hitbox.damage(attack)
