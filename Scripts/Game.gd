extends Node2D

@onready var leadMonsterTypes = [load("res://MonsterTypes/Squirtle.tres"), load("res://MonsterTypes/Squirtle.tres")]
@onready var monsterUI = $Canvas/MonsterUI
@onready var gameOverDialog = $Canvas/GameOverDialog
@onready var gameOverText = $Canvas/GameOverDialog/GameOverText

var leadMonster: Monster
var leadMonsterType: Resource

func startGame():
    leadMonsterType = leadMonsterTypes[randi() % leadMonsterTypes.size()]
    leadMonster = Monster.new(leadMonsterType)
    monsterUI.attach(leadMonster)
    leadMonster.ko.connect(self._on_lead_monster_ko)

func _ready():
    startGame()

func _on_subtract_health_button_pressed():
    leadMonster.healthBar.subtractHealth(1)

func _on_add_health_button_pressed():
    leadMonster.healthBar.addHealth(1)

func _on_subtract_heat_button_pressed():
    leadMonster.heatBar.subtractHeat(1)

func _on_add_heat_button_pressed():
    leadMonster.heatBar.addHeat(1)

func _on_lead_monster_ko(source: Monster.KO_SOURCE) -> void:
    match source:
        Monster.KO_SOURCE.FROZEN:
            gameOverText.text = "Brr! %s is numb! Try again." % leadMonster.name
        Monster.KO_SOURCE.BURNED:
            gameOverText.text = "Ouch! %s was burned up! Try again." % leadMonster.name
        Monster.KO_SOURCE.ZERO_HEALTH:
            gameOverText.text = "%s is exhausted! Try again." % leadMonster.name
    gameOverDialog.show()

func _on_game_over_dialog_confirmed():
    startGame()

func _on_game_over_dialog_canceled():
    startGame()
