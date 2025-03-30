extends Node

@export var updage_pool:Array[AbillityUpgrade]
@export var experience_manager: Node

var current_upgades = {
}

func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)

func on_level_up(new_level: int):
	var chosen_upgrade = updage_pool.pick_random() as AbillityUpgrade
	if chosen_upgrade == null:
		return
	var has_upgrade = current_upgades.has(chosen_upgrade.id)	
	if !has_upgrade:
		current_upgades[chosen_upgrade.id] = {
			"resource" : chosen_upgrade,
			"quantity" : 1
		}
	else:
		current_upgades[chosen_upgrade.id]["quantity"] += 1
