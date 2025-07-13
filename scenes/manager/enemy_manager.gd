extends Node

# 最大向量半径
const MAX_RANGE = 355

#基础敌人-老鼠
@export var base_enemy_scene : PackedScene
#巫师
@export var wizard_enemy_scene : PackedScene
#蝙蝠
@export var bat_enemy_scene : PackedScene
#地图时间
@export var arena_time_manager: Node

@onready var timer = $Timer

#重生时间
var base_spaw_time = 0
#怪权重表
var enemy_table = WeightedTable.new()


func _ready() -> void:
	enemy_table.add_item(base_enemy_scene, 10)
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)
	base_spaw_time = timer.wait_time


func get_spaw_position():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(null == player):
		return Vector2.ZERO
	
	#初始向量
	var spawn_position = Vector2.ZERO
	#敌人位置随机旋转向量
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	for i in 4:
		spawn_position = player.global_position + random_direction * MAX_RANGE
		#再加20像素，解决正好抵到墙上的bug
		var additional_check_offset = random_direction * 20
		# 构造一个参数实体 1 << 0 意思是1图层是第0位值是1，如果是 20图层是第19位值是2^19 写成 1 << 19
		var query_paramaters =  PhysicsRayQueryParameters2D.create(player.global_position,spawn_position + additional_check_offset,1 << 0)
		#检查是否有碰撞，返回一个map
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramaters)
		
		if result.is_empty():
			# 没有碰撞
			return spawn_position
		else:
			#有碰撞 旋转90度
			random_direction = random_direction.rotated(deg_to_rad(90))	
	return spawn_position
			
func on_timer_timeout():
	timer.start()
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(null == player):
		return
	
	#从敌人权重表取
	var enemy_scene = enemy_table.pick_item()
	var enemy = enemy_scene.instantiate() as Node2D
	
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	# 将随机向量加到敌人身上。
	enemy.global_position = get_spaw_position()
	

func on_arena_difficulty_increased(arena_difficulty: int):
	# 敌人生产速度随地图难度变快 最长 0.9秒
	var time_off = ( .1 / 12 ) * arena_difficulty
	time_off = min(.9, time_off)
	timer.wait_time = base_spaw_time - time_off
	
	#地图难度6时出现巫师敌人，5秒1级就是30秒
	if arena_difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 15)
	elif arena_difficulty == 12:
		enemy_table.add_item(bat_enemy_scene, 20)
