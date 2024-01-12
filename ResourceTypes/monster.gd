extends Resource
class_name Monster

var maxHealth: int
var currHealth: int

# let maxColdTicks, maxSafeTicks, maxHotTicks = 2, 3, 4
# all end-exclusive
# Cold Zone = 0, 1
# Safe Zone = 2, 3, 4
# Hot Zone = 5, 6, 7, 8

# Freezes below 0, after freezing, currColdTicks -= 1
var maxColdTicks: int
var currColdTicks: int

var maxSafeTicks: int

# Overheats beyond maxHotTicks, after overheating, currHotTicks -= 1
var maxHotTicks: int
var currHotTicks: int

var currHeat: int

signal updated

func _init(type: MonsterType):
    maxHealth = type.maxHealth
    currHealth = maxHealth - 1
    
    maxColdTicks = type.maxColdTicks
    currColdTicks = maxColdTicks
    
    maxSafeTicks = type.maxSafeTicks
    
    maxHotTicks = type.maxHotTicks
    currHotTicks = maxHotTicks
    
    # need to change to startingHeat when not debugging
    currHeat = RandomNumberGenerator.new().randi_range(0, maxColdTicks + maxSafeTicks + maxHotTicks)

func isCold(heat):
    return heat < currColdTicks
    
func isSafe(heat):
    return heat >= currColdTicks and heat < currColdTicks + maxSafeTicks

func isHot(heat):
    return heat >= currColdTicks + maxSafeTicks and heat < currColdTicks + maxSafeTicks + currHotTicks

func maxHeat():
    return currColdTicks + maxSafeTicks + currHotTicks

func addHealth(value: int):
    currHealth = clamp(currHealth + value, 0, maxHealth)
    emit_signal(updated.get_name())

func subtractHealth(value: int):
    currHealth = clamp(currHealth - value, 0, maxHealth)
    emit_signal(updated.get_name())

func addHeat(value: int):
    currHeat = clamp(currHeat + value, 0, self.maxHeat())
    emit_signal(updated.get_name())

func subtractHeat(value: int):
    currHeat = clamp(currHeat - value, 0, self.maxHeat())
    emit_signal(updated.get_name())
