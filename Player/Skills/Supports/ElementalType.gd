extends SupportSkill
class_name ElementalType

@export_enum("Physical","Electric","Fire","Ice","Poison") var value: String

func activate(skill: Skill) -> Skill:
	print("Before adding elemental : %s" % skill.elemental_type)
	skill.elemental_type = value
	print("After adding elemental : %s" % skill.elemental_type)
	return skill
