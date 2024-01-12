extends Control
class_name MonsterUI

var monster: Monster

func attach(toAttach: Monster):
    monster = toAttach

    $HealthBar.max_value = monster.maxHealth

    monster.health_updated.connect(render_health)
    render_health()

    monster.hotzone_updated.connect(render_bar)
    monster.coldzone_updated.connect(render_bar)
    monster.heat_updated.connect(render_bar)
    render_bar()

func render_bar():
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

func render_health():
    $HealthBar.value = monster.currHealth
