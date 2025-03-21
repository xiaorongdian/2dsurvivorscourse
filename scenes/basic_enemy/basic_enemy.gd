extends CharacterBody2D

var MAX_SPEED = 75

# Called when the node enters the scene tree for the first time.
func _ready() :
	$Area2D.area_entered.connect(on_area_enter)


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	var movme_vector = get_vactor_to_player()
	velocity = movme_vector * MAX_SPEED
	move_and_slide()

func get_vactor_to_player():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(player != null):
		return (player.global_position - global_position).normalized()
	return Vector2.ZERO
	
	
@warning_ignore("unused_parameter")
func on_area_enter(other_area : Area2D):
	queue_free()
