extends SupportSkill
class_name AddProjectile

@export var value: int
@export var level: int
@export var quality: int

var already_deducted
var base_less_damage = 36

func activate(skill: Skill) -> Skill:
	already_deducted = skill.attack_damage * (100 - (base_less_damage - level + (0.5 * quality))) / 100
	skill.attack_damage =  already_deducted
	skill.projectile_count += value
	return skill

func update_level(skill: Skill) -> Skill:
	level += 1
	skill.attack_damage += already_deducted
	already_deducted = skill.attack_damage * (100 - (base_less_damage - level + (0.5 * quality))) / 100
	skill.attack_damage =  already_deducted
	return skill
	
