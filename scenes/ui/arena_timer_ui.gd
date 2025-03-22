extends CanvasLayer

@export var arena_timer_manager : Node
@onready var label = $%Label


func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	if(null == arena_timer_manager):
		return
	var time_elapsed = arena_timer_manager.get_time_elapsed()
	label.text = format_second_to_str(time_elapsed)
	
	
func format_second_to_str(seconds :float):
	var min = floori(seconds/ 60) 
	var second = seconds - min * 60
	return str(min) + ":" + ("%02d" % floor(second))
	
