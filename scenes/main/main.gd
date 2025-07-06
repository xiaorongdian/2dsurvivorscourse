extends Node

@export var victory_screen_scene: PackedScene

func _ready() -> void:
	$%Player.health_component.died.connect(on_player_died)
	
	
func on_player_died():
	var victory_screen_scene_instance = victory_screen_scene.instantiate()
	add_child(victory_screen_scene_instance)
	victory_screen_scene_instance.set_defeat()
