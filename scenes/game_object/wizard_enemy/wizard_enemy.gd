extends CharacterBody2D

#转向缩放-1
@onready var visuals = $Visuals
#速度组件
@onready var velocity_component = $VelocityComponent

#是否移动
var is_move = false


func _ready() -> void:
	$HurtboxComponent.hited.connect(on_hit)
	
	
func _process(delta: float) -> void:
	if is_move:
		velocity_component.accelereate_to_playerr()
	else:
		velocity_component.decelerate()
	velocity_component.move(self)
  
	#根据移动方向纹理旋转一下
	var move_sign = sign(velocity.x)
	if move_sign != 0:
		#方式是父节点缩放-1，这样纹理和动画都翻转
		visuals.scale = Vector2(move_sign, 1)


func set_is_moving(moving: bool):
	is_move = moving
	
	
#命中时
func on_hit():
	$HitRandomAudioPlayerComponent.play_random()
