extends CanvasLayer


var options_scene = preload("res://scenes/ui/options_menu.tscn")


func _ready() -> void:
	%PlayButton.pressed.connect(on_play_pressed)
	%UpgradesButton.pressed.connect(on_upgrades_pressed)
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)


#开始按钮按下
func on_play_pressed():
	ScreenTransition.transition()
	await  ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	
	
func on_upgrades_pressed():
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file("res://scenes/ui/meta_menu.tscn")
	
	
#设置钮按下
func on_options_pressed():
	ScreenTransition.transition()
	await  ScreenTransition.transitioned_halfway
	var options_instance = options_scene.instantiate()
	add_child(options_instance)
	options_instance.back_pressed.connect(on_options_closed.bind(options_instance))
	
	
func on_quit_pressed():
	get_tree().quit()


func on_options_closed(options_instance:Node):
	options_instance.queue_free()
