extends CanvasLayer

@onready var panel_container: PanelContainer = %PanelContainer

var options_menu_scene = preload("res://scenes/ui/options_menu.tscn")
var is_closing


func _ready() -> void:
	get_tree().paused = true
	#偏移轴取中间
	panel_container.pivot_offset = panel_container.size/2
	%OptionsButton.pressed.connect(on_options_pressed)
	%QuitButton.pressed.connect(on_quit_pressed)
	%ResumeButton.pressed.connect(on_resume_pressed)
	$AnimationPlayer.play("default")

	var tween = create_tween()	
	tween.tween_property(panel_container, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_container, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	
#这个优先级高？
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") :
		close()
		#标记这个事件被处理
		get_tree().root.set_input_as_handled()
	

func close():
	if is_closing:
		return
		
	is_closing = true
		#倒放
	$AnimationPlayer.play_backwards("default")
	
	var tween = create_tween()	
	tween.tween_property(panel_container, "scale", Vector2.ONE, 0)
	tween.tween_property(panel_container, "scale", Vector2.ZERO, .3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BACK)
	
	await tween.finished
	get_tree().paused = false
	queue_free()
	
	
func on_resume_pressed():
	close()


func on_options_pressed():
	ScreenTransition.transition()
	await  ScreenTransition.transitioned_halfway
	var options_menu_instance = options_menu_scene.instantiate()
	add_child(options_menu_instance)
	options_menu_instance.back_pressed.connect(on_options_back_pressed.bind(options_menu_instance))
	

func on_quit_pressed():
	ScreenTransition.transition()
	await  ScreenTransition.transitioned_halfway
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/ui/main_menu.tscn")	


func on_options_back_pressed(options_menu: Node):
	ScreenTransition.transition()
	await  ScreenTransition.transitioned_halfway
	options_menu.queue_free()
	
