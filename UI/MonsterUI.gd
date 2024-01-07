extends Control
class_name MonsterUI

var monster: Monster

func render():
    $HealthBar.max_value = monster.maxHealth
    $HealthBar.value = monster.currHealth

    $HeatBar.max_value = monster.maxColdTicks + monster.maxSafeTicks + monster.maxHotTicks
    $HeatBar/Value.text =  "[center]%s[/center]" % monster.currHeat
    $HeatBar.value = monster.currHeat
    var sb = StyleBoxFlat.new()
    $HeatBar.add_theme_stylebox_override("fill", sb)
    if monster.isCold(monster.currHeat):
        sb.bg_color = Color("268bd2")
    if monster.isSafe(monster.currHeat):
        sb.bg_color = Color("859900")
    if monster.isHot(monster.currHeat):
        sb.bg_color = Color("dc322f")
