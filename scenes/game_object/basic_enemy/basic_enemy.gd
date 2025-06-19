extends CharacterBody2D

var MAX_SPEED = 40

@onready var health_component: HealthComponent = $HealthComponent
@onready var visuals = $Visuals


func _process(delta: float) -> void:
	var movme_vector = get_vactor_to_player()
	velocity = movme_vector * MAX_SPEED
	move_and_slide()
	
	#根据移动方向纹理旋转一下
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		#方式是父节点缩放-1，这样纹理和动画都翻转
		visuals.scale = Vector2(-move_sign, 1)
		

func get_vactor_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(player != null):
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
	
