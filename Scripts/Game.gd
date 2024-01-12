extends Node2D

@onready var leadMonsterType = load("res://Monsters/Tepig.tres")
@onready var leadMonster = Monster.new(leadMonsterType)
@onready var monsterUI = $Canvas/MonsterUI

func _ready():
    monsterUI.attach(leadMonster)

func _on_subtract_health_button_pressed():
    leadMonster.subtractHealth(1)

func _on_add_health_button_pressed():
    leadMonster.addHealth(1)

func _on_subtract_heat_button_pressed():
    leadMonster.subtractHeat(1)

func _on_add_heat_button_pressed():
    leadMonster.addHeat(1)
