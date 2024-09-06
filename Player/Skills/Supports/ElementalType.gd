extends SupportSkill
class_name ElementalType

@export_enum("Physical","Electric","Fire","Ice","Poison") var value: String
@export var level: int
@export var quality: int

func activate(skill: Skill) -> Skill:
	print("Before adding elemental : %s" % skill.elemental_type)
	skill.elemental_type = value
	print("After adding elemental : %s" % skill.elemental_type)
	return skill

func update_level(skill: Skill) -> Skill:
	level += 1
	return skill
