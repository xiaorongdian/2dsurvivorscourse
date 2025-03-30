extends Node
class_name UpgradeManager

#升级能力池
@export var upgrade_pool:Array[AbilityUpgrade]
@export var experience_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {
}

func _ready() -> void:
	experience_manager.level_up.connect(on_level_up)

func on_level_up(new_level: int):
	print("收到升級信號")
	#随机选一个能力在屏幕显示
	var chosen_upgrade = upgrade_pool.pick_random() as AbilityUpgrade
	print("选一个能力",chosen_upgrade)
	if chosen_upgrade == null:
		return
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	#加到场景树中就行
	add_child(upgrade_screen_instance)
	upgrade_screen_instance.set_ability_upgrades([chosen_upgrade] as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
	#apply_upgrade(chosen_upgrade)


func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)	
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource" : upgrade,
			"quantity" : 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1


func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)
	get_tree().paused = false
	queue_free()
	
