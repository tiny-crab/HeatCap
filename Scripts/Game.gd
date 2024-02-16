extends Node2D

@onready var leadMonsterTypes = [load("res://MonsterTypes/Squirtle.tres"), load("res://MonsterTypes/Tepig.tres"), load("res://MonsterTypes/Treecko.tres")]
@onready var monsterUI = $Canvas/MonsterUI
@onready var playerMonsterImage = $Canvas/PlayerMonsterImage
@onready var actionList = $Canvas/ActionList
@onready var gameOverDialog = $Canvas/GameOverDialog
@onready var gameOverText = $Canvas/GameOverDialog/GameOverText
@onready var turnCounter: TurnCounter = $Canvas/TurnCounter

var leadMonster: Monster
var leadMonsterType: Resource
var leadMonsterTypeIndex: int = 0

var activeParty: PARTY = PARTY.PLAYER
enum PARTY { PLAYER, SCENARIO }

func chooseLeadMonsterType() -> Resource:
    var type = leadMonsterTypes[leadMonsterTypeIndex % leadMonsterTypes.size()]
    leadMonsterTypeIndex += 1
    return type

func startGame():
    leadMonsterType = chooseLeadMonsterType()
    leadMonster = Monster.new(leadMonsterType)
    monsterUI.attach(leadMonster)
    actionList.attach(leadMonster)
    playerMonsterImage.texture = leadMonster.type.texture
    leadMonster.ko.connect(self._on_lead_monster_ko)
    leadMonster.take_action.connect(self._on_action_taken)

func endTurn():
    turnCounter.nextTurn()
    match activeParty:
        PARTY.PLAYER:
            activeParty = PARTY.SCENARIO
            print("It is now scenario's turn")
        PARTY.SCENARIO:
            activeParty = PARTY.PLAYER
            print("It is now player's turn")

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

func _on_action_taken(action: Action, monster: Monster):
    print("%s took action %s" % [monster.name, action.name])

func _on_game_over_dialog_confirmed():
    startGame()

func _on_game_over_dialog_canceled():
    startGame()

func _on_end_turn_pressed():
    endTurn()
