class_name HeatBar

# let maxColdTicks, maxSafeTicks, maxHotTicks = 2, 3, 4
# all end-exclusive
# Cold Zone = 0, 1
# Safe Zone = 2, 3, 4
# Hot Zone = 5, 6, 7, 8
#
# To begin:
#  0  1  2  3  4  5  6  7  8
# [Cold][Safe   ][Hot       ]
#
# If overheated once, hotZoneMax - 1:
#  0  1  2  3  4  5  6  7  X
# [Cold][Safe   ][Hot    ]
#
# If also frozen once, coldZoneMin + 1:
#  X  1  2  3  4  5  6  7  X
#    [C][Safe   ][Hot    ]
#
# If overheated again:
#  X  1  2  3  4  5  6  X  X
#    [C][Safe   ][Hot ]

func _init(initHeat, coldTicks, safeTicks, hotTicks):
    coldZoneMin = 0
    coldZoneMax = coldTicks - 1
    currColdZoneMin = coldZoneMin

    safeZoneMin = coldTicks
    safeZoneMax = coldTicks + safeTicks - 1

    hotZoneMin = coldTicks + safeTicks
    hotZoneMax = coldTicks + safeTicks + hotTicks - 1
    currHotZoneMax = hotZoneMax

    currHeat = initHeat
    startingHeat = initHeat

var startingHeat: int

signal heat_updated
var currHeat: int:
    set(value):
        currHeat = value
        emit_signal(heat_updated.get_name())

var coldZoneMin: int
var coldZoneMax: int

signal coldzone_updated
var currColdZoneMin: int:
    set(value):
        currColdZoneMin = value
        emit_signal(coldzone_updated.get_name())

var safeZoneMin: int
var safeZoneMax: int

var hotZoneMin: int
var hotZoneMax: int
signal hotzone_updated
var currHotZoneMax: int:
    set(value):
        currHotZoneMax = value
        emit_signal(hotzone_updated.get_name())

var isCold: bool:
    get:
        return currHeat >= currColdZoneMin and currHeat < safeZoneMin
var isSafe: bool:
    get:
        return currHeat >= safeZoneMin and currHeat <= safeZoneMax
var isHot: bool:
    get:
        return currHeat > safeZoneMax and currHeat <= currHotZoneMax

func addHeat(value: int):
    currHeat += value

func subtractHeat(value: int):
    currHeat -= value
