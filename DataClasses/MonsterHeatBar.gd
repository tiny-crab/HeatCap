class_name MonsterHeatBar extends HeatBar

# The cold zone has been damaged
signal freeze
# The hot zone has been damaged
signal overheat
# The cold zone has been fully depleted
signal frozen
# The hot zone has been fully depleted
signal burned

func _init(type: MonsterType):
    super(type.startingHeat, type.maxColdTicks, type.maxSafeTicks, type.maxHotTicks)
    heat_updated.connect(_on_heat_change)

func _on_heat_change() -> void:
    if (currHeat < currColdZoneMin):
        currColdZoneMin = clamp(currColdZoneMin + 1, coldZoneMin, safeZoneMin)
        if currColdZoneMin == safeZoneMin:
            frozen.emit()
            return
        else:
            freeze.emit()
        currHeat = clamp(startingHeat, currColdZoneMin, currHotZoneMax)
    if (currHeat > currHotZoneMax):
        currHotZoneMax = clamp(currHotZoneMax - 1, safeZoneMax, hotZoneMax)
        if currHotZoneMax == safeZoneMax:
            burned.emit()
            return
        else:
            overheat.emit()
        currHeat = clamp(startingHeat, currColdZoneMin, currHotZoneMax)
