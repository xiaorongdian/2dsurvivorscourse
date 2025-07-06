extends CanvasLayer


func _ready() -> void:
	%PlayButton.pressed.connect(on_play_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


#开始按钮按下
func on_play_pressed():
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	
	
#设置钮按下
func on_options_pressed():
	pass
	
	

func on_quit_pressed():
	get_tree().quit()
