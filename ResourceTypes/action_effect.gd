extends Resource
class_name ActionEffect

@export_enum("Damage", "Block", "Evade") var effectName: String = "Damage"

func default_effect():
    pass

func damage():
    pass
    
func block():
    pass
    
func evade():
    pass
    
func get_effect():
    match effectName:
        "Damage": return damage
        "Block": return block
        "Evade": return evade
        _: return default_effect
        
