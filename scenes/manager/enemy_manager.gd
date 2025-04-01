extends Node

@export var base_enemy_scene : PackedScene

const MAX_RANGE = 375


func _ready() -> void:
	$Timer.timeout.connect(on_timer_timeout)


func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(null == player):
		return
	
	var randRange = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var enemy = base_enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = player.global_position + randRange * MAX_RANGE
	
