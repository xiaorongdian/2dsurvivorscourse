extends Node

#钻头半径
const BASE_RANGE = 100
const BASE_DAMAGE = 15

@export var anvil_ability_scene: PackedScene

#升级的数量
var anvil_count = 0


func _ready() -> void:
	on_timer_timeout()
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
		
	#随机方向
	var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	#对称
	var additional_rotation_degress = 360.0 / (anvil_count + 1)
	var anvil_distance = randf_range(0, BASE_RANGE)
	for i in anvil_count + 1:
		var adjusted_direction = direction.rotated(deg_to_rad(i * additional_rotation_degress))
		
		#乘以随机距离
		var spawn_position = player.global_position + adjusted_direction * anvil_distance
		
		# 构造一个参数实体 1 << 0 意思是1图层是第0位值是1，如果是 20图层是第19位值是2^19 写成 1 << 19
		var query_paramaters =  PhysicsRayQueryParameters2D.create(player.global_position,spawn_position,1 << 0)
		#检查是否有碰撞，返回一个map
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramaters)
		#如果有碰撞 碰到 怪物
		if !result.is_empty():
			spawn_position = result["position"]
		
		var anvil_ability = anvil_ability_scene.instantiate() as AnvilAbility
		get_tree().get_first_node_in_group("foreground_layer").add_child(anvil_ability)
		anvil_ability.global_position = spawn_position
		anvil_ability.hitbox_component.damage = BASE_DAMAGE
	
	
func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "anvil_count":
		anvil_count = current_upgrades["anvil_count"]["quantity"]
