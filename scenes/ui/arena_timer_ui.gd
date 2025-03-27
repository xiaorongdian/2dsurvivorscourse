extends CanvasLayer
#上面的时间计时ui
@export var arena_timer_manager : Node
@onready var label = $%Label


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if(null == arena_timer_manager):
		return
	var time_elapsed = arena_timer_manager.get_time_elapsed()
	label.text = format_second_to_str(time_elapsed)
	
	
func format_second_to_str(seconds :float):
	var mins = floori(seconds/ 60) 
	var second = seconds - mins * 60
	return str(mins) + ":" + ("%02d" % floor(second))
	
