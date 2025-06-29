extends Node

const MAX_RANGE = 150
#基础伤害
var base_damage = 5
#伤害增长百分比 从1开始
var additional_damage_percent = 1
var base_wait_time

@export var sword_ability: PackedScene

func _ready() -> void:
	base_wait_time = $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(null == player):
		return
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies.filter(func (enmy : Node2D):
		return enmy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	
	if(enemies.size() == 0):
		return
	
	enemies.sort_custom(func (a : Node2D, b : Node2D):
		var a_position = a.global_position.distance_squared_to(player.global_position)
		var b_position = b.global_position.distance_squared_to(player.global_position)
		return a_position < b_position
		)
	
	var sword_instance = sword_ability.instantiate() as SwordAbility
	#弄一个主场景节点统一管理游戏中临时生成的child
	var forground_layer = get_tree().get_first_node_in_group("foreground_layer")
	forground_layer.add_child(sword_instance)
	#伤害=基础 * 百分比
	sword_instance.hitbox_component.damage = base_damage * additional_damage_percent
	
	#随机转个角度
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_position = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_position.angle()
	
	
#升级剑时
func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "sword_rate":
		var percent_reduction = current_upgrades["sword_rate"]["quantity"] * .1
		base_wait_time *= 1 - percent_reduction
		$Timer.wait_time = max(base_wait_time, 0.1)
		$Timer.start()
	elif upgrade.id == "sword_damage":
		additional_damage_percent = 1 + current_upgrades["sword_damage"]["quantity"] * .15
