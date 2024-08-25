extends SupportSkill
class_name AddProjectile

@export var value: int

func activate(skill: Skill) -> Skill:
	print("Before adding proj : %s" % skill.projectile_count)
	skill.projectile_count += value
	print("After adding proj : %s" % skill.projectile_count)
	return skill
