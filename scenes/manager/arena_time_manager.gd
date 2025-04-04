extends Node

@onready var timer = $Timer

@export var end_screen_scene: PackedScene


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)


func get_time_elapsed():
	return $Timer.wait_time - $Timer.time_left


func on_timer_timeout():
	var end_screen_instance = end_screen_scene.instantiate()
	add_child(end_screen_instance)
