class_name TurnCounter extends VBoxContainer


@onready var ui: Label = $TurnCount
@onready var counterTextTemplate: String = "Turn %s"

var turnCounter: int = 1:
    set(value):
        turnCounter = value
        updateUI()

func _ready():
    updateUI()

func nextTurn():
    turnCounter += 1

func updateUI():
    ui.text = counterTextTemplate % turnCounter
