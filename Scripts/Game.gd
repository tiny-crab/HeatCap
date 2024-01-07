extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
    var leadMonsterType = load("res://Monsters/Tepig.tres")
    var leadMonster = Monster.new(leadMonsterType)
    
    var monsterUI = $Canvas/MonsterUI
    monsterUI.monster = leadMonster
    monsterUI.render()
