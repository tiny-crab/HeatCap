extends HBoxContainer

var action: Action
var monster: Monster

func attach(action: Action, monster: Monster):
    self.action = action
    self.monster = monster
    renderOption()

func renderOption():
    $VBoxContainer/Name.text = action.name
    $VBoxContainer/FlavorText.text = action.flavorText % monster.name
    # TODO to interpolate the right values in effectDescription, need to be able to pull properties
    # from child classes, not the Action interface. We'd need to mock-apply the effect to the target
    # as well to identify how much damage an attack would do, how much damage would be blocked, etc.
    $VBoxContainer/Description.text = action.effectDescription


func _on_act_pressed():
    monster.act(action)
