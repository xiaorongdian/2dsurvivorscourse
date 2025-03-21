extends Node

const MAX_RANGE = 150
@export var sword_abillity: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	$Timer.timeout.connect(on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(null == player):
		return
	var enemies = get_tree().get_nodes_in_group("enemy")
	enemies.filter(func (enmy : Node2D):
		return enmy.global_position.distance_squared_to(player.global_position) < pow(MAX_RANGE, 2)
	)
	
	if(enemies.size() == 0):
		return
	
	enemies.sort_custom(func (a : Node2D, b : Node2D):
		var a_position = a.global_position.distance_squared_to(player.global_position)
		var b_position = b.global_position.distance_squared_to(player.global_position)
		return a_position < b_position
		)
	
	var sword_instance = sword_abillity.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = enemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0, TAU)) * 4
	
	var enemy_position = enemies[0].global_position - sword_instance.global_position
	sword_instance.rotation = enemy_position.angle()
	
	
