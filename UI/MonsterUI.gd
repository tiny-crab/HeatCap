extends Control
class_name MonsterUI

var monster: Monster

func attach(toAttach: Monster):
    monster = toAttach
    monster.updated.connect(render)
    render()

func render():
    $HealthBar.max_value = monster.maxHealth
    $HealthBar.value = monster.currHealth

    $HeatBar.max_value = monster.currHotZoneMax
    $HeatBar.min_value = monster.currColdZoneMin
    $HeatBar/Value.text =  "[center]%s[/center]" % monster.currHeat
    $HeatBar.value = monster.currHeat
    var sb = StyleBoxFlat.new()
    $HeatBar.add_theme_stylebox_override("fill", sb)
    if monster.isCold:
        sb.bg_color = Color("268bd2")
    if monster.isSafe:
        sb.bg_color = Color("859900")
    if monster.isHot:
        sb.bg_color = Color("dc322f")
