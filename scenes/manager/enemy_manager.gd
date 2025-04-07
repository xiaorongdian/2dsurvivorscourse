extends Node

const MAX_RANGE = 375

@export var base_enemy_scene : PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_spaw_time = 0


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)
	base_spaw_time = timer.wait_time

func on_timer_timeout():
	timer.start()
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(null == player):
		return
	
	var randRange = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var enemy = base_enemy_scene.instantiate() as Node2D
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.add_child(enemy)
	enemy.global_position = player.global_position + randRange * MAX_RANGE
	

func on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = ( .1 / 12 ) * arena_difficulty
	time_off = min(.9, time_off)
	timer.wait_time = base_spaw_time - time_off
