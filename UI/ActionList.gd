extends VBoxContainer

var monster: Monster
@onready var actionOptions: Array[Node] = [$ActionOption0, $ActionOption1, $ActionOption2, $ActionOption3]

func attach(toAttach: Monster):
    monster = toAttach
    renderActions()

func renderActions():
    var numPossibleActions = monster.actions.size()
    for i in actionOptions.size():
        if i < numPossibleActions:
            actionOptions[i].attach(monster.actions[i], monster)
        else:
            actionOptions[i].hide()

