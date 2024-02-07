class_name DamageEffect extends ActionEffect

@export var damageValue: int = 0

func apply(target: Monster, source: Monster):
    target.damage(damageValue)
