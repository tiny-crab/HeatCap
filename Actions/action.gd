extends Resource
class_name Action

@export var name: String = "Default Action"
@export var flavorText: String = "Your monster does something."
@export var effectDescription: String = "Something happens."
@export var effectList: Array[ActionEffect] = []
@export var priority: int = 0
