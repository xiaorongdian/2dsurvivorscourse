extends Node

class_name HealthComponent

signal died

@export var max_health: float = 10
var current_health


func _ready() -> void:
	current_health = max_health


func damage(damage_amount: float):
	current_health = max(current_health - damage_amount, 0)
	if(current_health == 0):
		died.emit()
		owner.queue_free()
	
