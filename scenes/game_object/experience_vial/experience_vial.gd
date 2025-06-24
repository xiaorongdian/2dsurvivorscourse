extends Node2D

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var sprite: Sprite2D = $Sprite2D


func _ready() -> void:
	$Area2D.area_entered.connect(on_area_enter)
	

#搜集经验瓶
func tween_collect(percent: float, start_position: Vector2):
	var player = get_tree().get_first_node_in_group("player")
	if player == null:
		return
	#经验瓶挪到玩家
	global_position = start_position.lerp(player.global_position, percent)
	
	var direction_from_start = player.global_position - start_position
	#旋转的更平滑一些
	var target_rotation = direction_from_start.angle() + deg_to_rad(90)
	rotation = lerp_angle(rotation, target_rotation, 1 - exp(-2 * get_process_delta_time()))
	
	
func disable_collision():
	collision_shape_2d.disabled = true


func collect():
	#发信号
	GameEvents.emit_experiecnce_vial_collecter(1)
	queue_free()


func on_area_enter(other_area: Area2D):
	#延迟调用使碰撞形状失效，目的不会多次碰撞。
	Callable(disable_collision).call_deferred()
	var tween = create_tween()
	#使动画并行运行
	tween.set_parallel()
	#0.0~1.0不断传入 tween_collect方法，第二个参数需要用bind传参
	tween.tween_method(tween_collect.bind(global_position), 0.0, 1.0, .5)\
	.set_ease(Tween.EASE_IN)\
	.set_trans(Tween.TRANS_BACK)

	#将scale属性逐渐变成0，延迟动画0.45秒
	tween.tween_property(sprite, "scale", Vector2.ZERO, .05).set_delay(.45)
	#后的tween串行
	tween.chain()
	tween.tween_callback(collect)
	
