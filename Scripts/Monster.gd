extends Resource
class_name Monster

var maxHealth: int
var currentHealth: int

func _init(type: MonsterType):
    maxHealth = type.maxHealth
    currentHealth = maxHealth - 1
