extends CanvasLayer
#失败了

@onready var panel_container = $%PanelContainer


func _ready() -> void:
	#将轴心设置到中间
	panel_container.pivot_offset = panel_container.size / 2
	var tween = create_tween()
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	get_tree().paused = true
	$%ContinueButton.pressed.connect(on_continue_button_pressed)
	$%QuitButton.pressed.connect(on_quit_button_pressed)


#播放短曲
func play_jingle(defeat: bool = false):
	if defeat:
		MusicPlayer.stop()
		$DefeatPlayerComponent.play_random()
	else:
		$VictoryPlayerComponent.play_random()	
	

func set_defeat():
	play_jingle(true)
	$%TitleLabel.text = "失败"
	$%DescriptionLabel.text = "差一点就成功啦!"


func on_continue_button_pressed():
	MusicPlayer.play()
	ScreenTransition.transition()
	await  ScreenTransition.transitioned_halfway
	
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/meta_menu.tscn")


func on_quit_button_pressed():
	MusicPlayer.play()
	get_tree().paused = false
	ScreenTransition.transition_to_scene("res://scenes/ui/main_menu.tscn")
	await ScreenTransition.transitioned_halfway
	
