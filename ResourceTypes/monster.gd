extends Resource
class_name Monster

# This monster was ko'd
enum KO_SOURCE {FROZEN, BURNED, ZERO_HEALTH}
signal ko(source: KO_SOURCE)

var heatBar: MonsterHeatBar

var name: String
var maxHealth: int

signal health_updated
var currHealth: int:
    set(value):
        currHealth = value
        emit_signal(health_updated.get_name())

func _init(type: MonsterType):
    name = type.name
    maxHealth = type.maxHealth
    currHealth = maxHealth - 1
    heatBar = MonsterHeatBar.new(type)
    heatBar.frozen.connect(_on_frozen)
    heatBar.burned.connect(_on_burned)

func _on_frozen() -> void:
    ko.emit(KO_SOURCE.FROZEN)

func _on_burned() -> void:
    ko.emit(KO_SOURCE.BURNED)

func addHealth(value: int) -> void:
    currHealth = clamp(currHealth + value, 0, maxHealth)

func subtractHealth(value: int) -> void:
    currHealth = clamp(currHealth - value, 0, maxHealth)
    if (currHealth == 0):
        ko.emit(KO_SOURCE.ZERO_HEALTH)
