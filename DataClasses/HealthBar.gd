class_name HealthBar

signal health_updated
signal zero_health

var maxHealth: int
var currHealth: int:
    set(value):
        currHealth = value
        health_updated.emit()

func _init(currHealth, maxHealth):
    self.currHealth = currHealth
    self.maxHealth = maxHealth

func addHealth(value: int) -> void:
    currHealth = clamp(currHealth + value, 0, maxHealth)

func subtractHealth(value: int) -> void:
    currHealth = clamp(currHealth - value, 0, maxHealth)
    if (currHealth == 0):
        zero_health.emit()
