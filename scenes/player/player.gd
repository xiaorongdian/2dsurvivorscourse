extends CharacterBody2D

const MAX_SPEED = 125
const JIA_SU_PING_HUA = 25 #角色移动缓冲加速粒度

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var movme_vector = get_movment_vector()
	var direction = movme_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * JIA_SU_PING_HUA))
	move_and_slide()


func get_movment_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
	
	
	
