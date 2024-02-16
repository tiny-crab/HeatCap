extends Resource
class_name MonsterType

@export var name: String = "MonsterName"
@export var maxHealth: int = 25
@export var startingHeat: int = 1
@export var maxColdTicks: int = 1
@export var maxSafeTicks: int = 1
@export var maxHotTicks: int = 1
@export var texture: Texture

@export var actions: Array[Action] = []
