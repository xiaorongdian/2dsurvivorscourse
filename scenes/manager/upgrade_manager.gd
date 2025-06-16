extends Node

#升级能力池
@export var upgrade_pool:Array[AbilityUpgrade]
#经验管理
@export var experience_manager: Node
#升级场景
@export var upgrade_screen_scene: PackedScene

#当前拥有的能力
var current_upgrades = {
}

func _ready():
	experience_manager.level_up.connect(on_level_up)


#升级后记录一下
func apply_upgrade(upgrade: AbilityUpgrade):
	var has_upgrade = current_upgrades.has(upgrade.id)	
	#如果当前能力中没有则添加，有则+1
	if !has_upgrade:
		current_upgrades[upgrade.id] = {
			"resource" : upgrade,
			"quantity" : 1
		}
	else:
		current_upgrades[upgrade.id]["quantity"] += 1
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


#选择升级时显示的类目
func pick_upgrades():
	var chosen_upgrades:Array[AbilityUpgrade] = []
	#复制一个新的数组，不影响原数组
	var filtered_upgrades = upgrade_pool.duplicate()
	for i in upgrade_pool.size():
		#随机选一个能力在屏幕显示
		var chosen_upgrade = filtered_upgrades.pick_random() as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)
		#过滤 遍历一下返回true就保留下来 Lambda 表达式
		filtered_upgrades = filtered_upgrades.filter(func (upgrade): return upgrade.id != chosen_upgrade.id)
	return chosen_upgrades


#选中一个能力
func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)


func on_level_up(new_level: int):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	#加到场景树中就行
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
