extends Resource
class_name Monster

# This monster was ko'd
signal ko(source: KO_SOURCE)
enum KO_SOURCE {FROZEN, BURNED, ZERO_HEALTH}

var name: String
var heatBar: MonsterHeatBar
var healthBar: HealthBar

func _init(type: MonsterType):
    name = type.name

    healthBar = HealthBar.new(type.maxHealth, type.maxHealth)
    healthBar.zero_health.connect(_on_zero_health)

    heatBar = MonsterHeatBar.new(type)
    heatBar.frozen.connect(_on_frozen)
    heatBar.burned.connect(_on_burned)

func damage(value: int) -> void:
    healthBar.subtractHealth(value)

func _on_frozen() -> void:
    ko.emit(KO_SOURCE.FROZEN)

func _on_burned() -> void:
    ko.emit(KO_SOURCE.BURNED)

func _on_zero_health() -> void:
    ko.emit(KO_SOURCE.ZERO_HEALTH)
