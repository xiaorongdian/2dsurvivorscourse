extends Node2D

#命中组件
@onready var hitbox_component: HitboxComponent = $HitboxComponent

#初始化斧头的旋转方向
var base_rotation = Vector2.RIGHT

#最大半径
const MAX_RADIUS = 100

func _ready() -> void:
	base_rotation = Vector2.RIGHT.rotated(randf_range(0, TAU))
	#编程动画
	var tween = create_tween()
	#从0到2π 用时 3 秒 0.0~2.0不断传入 tween_method方法
	tween.tween_method(tween_method, 0.0, 2.0, 2)
	#tween运行完调用，使斧头消失
	tween.tween_callback(queue_free)

func tween_method(rotations: float):
	#旋转百分比 2是我们最大值 rotations 在2秒内从0增长到2
	var percent = rotations / 2
	#百分比*半径=当前半径
	var currect_radius = percent * MAX_RADIUS
	#现在的方向
	var current_direction = base_rotation.rotated(rotations * TAU)
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	#初始位置在玩家身上 方向*半径加上初始位置
	global_position = player.global_position + (current_direction * currect_radius)
