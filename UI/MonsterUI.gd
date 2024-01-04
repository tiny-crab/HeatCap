extends Control
class_name MonsterUI

var monster: Monster

func render():
    $HealthBar.max_value = monster.maxHealth
    $HealthBar.value = monster.currentHealth
