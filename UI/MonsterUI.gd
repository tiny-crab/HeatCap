extends Control
class_name MonsterUI

var monster: Monster

func attach(toAttach: Monster):
    monster = toAttach

    $HealthBar.max_value = monster.maxHealth

    monster.health_updated.connect(render_health)
    render_health()

    monster.heatBar.hotzone_updated.connect(render_bar)
    monster.heatBar.coldzone_updated.connect(render_bar)
    monster.heatBar.heat_updated.connect(render_bar)
    render_bar()

func render_bar():
    $HeatBar.max_value = monster.heatBar.currHotZoneMax
    $HeatBar.min_value = monster.heatBar.currColdZoneMin
    $HeatBar/Value.text =  "[center]%s[/center]" % monster.heatBar.currHeat
    $HeatBar.value = monster.heatBar.currHeat
    var sb = StyleBoxFlat.new()
    $HeatBar.add_theme_stylebox_override("fill", sb)
    if monster.heatBar.isCold:
        sb.bg_color = Color("268bd2")
    if monster.heatBar.isSafe:
        sb.bg_color = Color("859900")
    if monster.heatBar.isHot:
        sb.bg_color = Color("dc322f")

func render_health():
    $HealthBar.value = monster.currHealth
