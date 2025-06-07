extends Node

# 最大向量半径
const MAX_RANGE = 375

@export var base_enemy_scene : PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_spaw_time = 0


func _ready() -> void:
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
	var randRange = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	for i in 4:
		spawn_position = player.global_position + randRange * MAX_RANGE
		# 构造一个参数实体 1 << 0 意思是1图层是第0位值是1，如果是 20图层是第19位值是2^19 写成 1 << 19
		var query_paramaters =  PhysicsRayQueryParameters2D.create(player.global_position,spawn_position,1 << 0)
		#检查是否有碰撞，返回一个map
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramaters)
		
		if result.is_empty():
			# 没有碰撞
			return spawn_position
		else:
			#有碰撞 旋转90度
			randRange = randRange.rotated(deg_to_rad(90))	
	return spawn_position
			
func on_timer_timeout():
	timer.start()
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(null == player):
		return

	var enemy = base_enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	# 将随机向量加到敌人身上。
	enemy.global_position = get_spaw_position()
	

func on_arena_difficulty_increased(arena_difficulty: int):
	# 敌人生产速度随地图难度变快 最长 0.9秒
	var time_off = ( .1 / 12 ) * arena_difficulty
	time_off = min(.9, time_off)
	timer.wait_time = base_spaw_time - time_off
