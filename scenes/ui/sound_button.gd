extends Button



func _ready() -> void:
	#按下时事件
	pressed.connect(on_pressed)


func on_pressed():
	$RandomStreamPlayerComponent.play_random()
