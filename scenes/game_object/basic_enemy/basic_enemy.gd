extends CharacterBody2D

var MAX_SPEED = 40

@onready var health_component: HealthComponent = $HealthComponent


func _process(delta: float) -> void:
	var movme_vector = get_vactor_to_player()
	velocity = movme_vector * MAX_SPEED
	move_and_slide()

func get_vactor_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(player != null):
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
	
