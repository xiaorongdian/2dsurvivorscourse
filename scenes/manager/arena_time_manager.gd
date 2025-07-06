extends Node

#地图难度提升信号
signal arena_difficulty_increased(arena_difficulty: int)
#每5秒升一级
const DIFFICULTY_INTERVAL = 5

@export var victory_screen_scene: PackedScene

@onready var timer = $Timer

#随着时间推移地图难度提升
var arena_difficulty = 0


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func _process(delta: float) -> void:
	#每5秒升一级
	var next_timer_target = timer.wait_time - ((arena_difficulty + 1) * DIFFICULTY_INTERVAL)
	
	if timer.time_left <= next_timer_target:
		arena_difficulty += 1
		arena_difficulty_increased.emit(arena_difficulty)
	

func get_time_elapsed():
	return $Timer.wait_time - $Timer.time_left


func on_timer_timeout():
	var victory_screen_scene_instance = victory_screen_scene.instantiate()
	add_child(victory_screen_scene_instance)
	victory_screen_scene_instance.play_jingle(false)
