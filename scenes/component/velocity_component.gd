#速度组件
extends Node

#最大移动速度
@export var max_speed:int = 40 
#加速度
@export var acceleration:float = 5


#速度
var velocity = Vector2.ZERO


#朝玩家的加速度
func accelereate_to_playerr():
	var owner_node2d = owner as Node2D
	if owner_node2d == null:
		return
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null :
		return
	
	var direction = (player.global_position - owner_node2d.global_position).normalized()
	accelerate_in_direction(direction)
	
	
#在某个方向上更新速度
func accelerate_in_direction(direction:Vector2):
	var desired_velocity = direction * max_speed
	velocity = velocity.lerp(desired_velocity, 1 - exp(- acceleration * get_process_delta_time()))


#减速函数
func decelerate():
	accelerate_in_direction(Vector2.ZERO)


#移动
func move(character_body: CharacterBody2D):
	#速度=当前速度
	character_body.velocity = velocity
	#移动
	character_body.move_and_slide()
	#当前速度 = 移动后速度（可能上一步碰撞了会改变速度）
	velocity = character_body.velocity
