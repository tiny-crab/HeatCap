extends Resource
class_name Monster

# This monster was ko'd
enum KO_SOURCE {FROZEN, OVERHEATED, ZERO_HEALTH}
signal ko(source: KO_SOURCE)

# TODO put all signals up here in the top of this file to help organize

var name: String
var maxHealth: int

signal health_updated
var currHealth: int:
    set(value):
        currHealth = value
        emit_signal(health_updated.get_name())

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

# TODO can all this info be separated into another object? It's super cluttered in here

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

func _init(type: MonsterType):
    name = type.name

    maxHealth = type.maxHealth
    currHealth = maxHealth - 1

    coldZoneMin = 0
    coldZoneMax = type.maxColdTicks - 1
    currColdZoneMin = coldZoneMin

    safeZoneMin = type.maxColdTicks
    safeZoneMax = type.maxColdTicks + type.maxSafeTicks - 1

    hotZoneMin = type.maxColdTicks + type.maxSafeTicks
    hotZoneMax = type.maxColdTicks + type.maxSafeTicks + type.maxHotTicks - 1
    currHotZoneMax = hotZoneMax

    currHeat = type.startingHeat
    startingHeat = type.startingHeat

func addHealth(value: int):
    currHealth = clamp(currHealth + value, 0, maxHealth)

func subtractHealth(value: int):
    currHealth = clamp(currHealth - value, 0, maxHealth)
    if (currHealth == 0):
        ko.emit(KO_SOURCE.ZERO_HEALTH)

func addHeat(value: int):
    currHeat += value
    if (currHeat > currHotZoneMax):
        # The monster overheated!
        currHotZoneMax = clamp(currHotZoneMax - 1, safeZoneMax, hotZoneMax)
        if (currHotZoneMax == safeZoneMax):
            ko.emit(KO_SOURCE.OVERHEATED)
        currHeat = clamp(startingHeat, currColdZoneMin, currHotZoneMax)

func subtractHeat(value: int):
    currHeat -= value
    if (currHeat < currColdZoneMin):
        # The monster froze!
        currColdZoneMin = clamp(currColdZoneMin + 1, coldZoneMin, safeZoneMin)
        if (currColdZoneMin == safeZoneMin):
            ko.emit(KO_SOURCE.FROZEN)
        currHeat = clamp(startingHeat, currColdZoneMin, currHotZoneMax)
