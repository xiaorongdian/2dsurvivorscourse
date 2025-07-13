extends Node

#经验管理
@export var experience_manager: Node
#升级场景
@export var upgrade_screen_scene: PackedScene

#当前拥有的能力
var current_upgrades = {}

#升级能力池
var upgrade_pool:WeightedTable = WeightedTable.new()

#预加载能力资源
#能力-斧
var upgrade_axe = preload("res://resources/upgrade/axe.tres")
#能力-铁钻
var upgrade_anvil = preload("res://resources/upgrade/anvil.tres")
#伤害-斧
var upgrade_axe_damage = preload("res://resources/upgrade/axe_damage.tres")
#速度-剑
var upgrade_sword_rate = preload("res://resources/upgrade/sword_rate.tres")
#伤害剑
var upgrade_sword_damage = preload("res://resources/upgrade/sword_damage.tres")
#速度-玩家
var upgrade_player_speed = preload("res://resources/upgrade/player_speed.tres")


func _ready():
	#放到池子里
	upgrade_pool.add_item(upgrade_axe, 10)
	upgrade_pool.add_item(upgrade_anvil, 10)
	upgrade_pool.add_item(upgrade_sword_rate, 10)
	upgrade_pool.add_item(upgrade_sword_damage, 10)
	upgrade_pool.add_item(upgrade_player_speed, 5)
	experience_manager.level_up.connect(on_level_up)


#选择升级之后触发
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
	if upgrade.max_quantity > 0:
		var current_quantity = current_upgrades[upgrade.id]["quantity"]
		if current_quantity == upgrade.max_quantity:
			upgrade_pool.remove_item(upgrade)
	
	update_upgrade_pool(upgrade)
	GameEvents.emit_ability_upgrade_added(upgrade, current_upgrades)


#修正一下升级能力池
func update_upgrade_pool(chosen_upgrade: AbilityUpgrade):
	#如果选择了获得斧头能力，则升级池中加入斧头伤害增加的选项
	if chosen_upgrade.id == upgrade_axe.id:
		upgrade_pool.add_item(upgrade_axe_damage, 10)


#选择升级时显示的类目
func pick_upgrades():
	var chosen_upgrades:Array[AbilityUpgrade] = []
	for i in 3:
		#如果池子里的数量与选择的数量相同
		if upgrade_pool.items.size() == chosen_upgrades.size():
			break
		#随机选一个能力在屏幕显示
		var chosen_upgrade = upgrade_pool.pick_item(chosen_upgrades) as AbilityUpgrade
		chosen_upgrades.append(chosen_upgrade)
		
	return chosen_upgrades


#选中一个能力
func on_upgrade_selected(upgrade: AbilityUpgrade):
	apply_upgrade(upgrade)


func on_level_up(new_level: int):
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	#加到场景树中就行
	add_child(upgrade_screen_instance)
	var chosen_upgrades = pick_upgrades()
	#能力加到UI中
	upgrade_screen_instance.set_ability_upgrades(chosen_upgrades as Array[AbilityUpgrade])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
