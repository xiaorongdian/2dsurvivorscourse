extends Node

@export var victory_screen_scene: PackedScene

var pause_menu_scene = preload("res://scenes/ui/pause_menu.tscn")


func _ready() -> void:
	$%Player.health_component.died.connect(on_player_died)
	
	
#这个优先级高？
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		add_child(pause_menu_scene.instantiate())
		#标记这个事件被处理
		get_tree().root.set_input_as_handled()
	
	
func on_player_died():
	var victory_screen_scene_instance = victory_screen_scene.instantiate()
	add_child(victory_screen_scene_instance)
	victory_screen_scene_instance.set_defeat()
	MetaProgression.save()
