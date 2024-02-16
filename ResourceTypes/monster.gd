extends Resource
class_name Monster

# This monster was ko'd
signal ko(source: KO_SOURCE)
enum KO_SOURCE {FROZEN, BURNED, ZERO_HEALTH}

signal take_action(action: Action, monster: Monster)

var name: String
var heatBar: MonsterHeatBar
var healthBar: HealthBar
var actions: Array[Action]
var type: MonsterType

func _init(type: MonsterType):
    name = type.name

    healthBar = HealthBar.new(type.maxHealth, type.maxHealth)
    healthBar.zero_health.connect(_on_zero_health)

    heatBar = MonsterHeatBar.new(type)
    heatBar.frozen.connect(_on_frozen)
    heatBar.burned.connect(_on_burned)

    actions = type.actions

    self.type = type

func act(action: Action) -> void:
    take_action.emit(action, self)

func damage(value: int) -> void:
    healthBar.subtractHealth(value)

func _on_frozen() -> void:
    ko.emit(KO_SOURCE.FROZEN)

func _on_burned() -> void:
    ko.emit(KO_SOURCE.BURNED)

func _on_zero_health() -> void:
    ko.emit(KO_SOURCE.ZERO_HEALTH)
