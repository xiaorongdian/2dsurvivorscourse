extends CanvasLayer


signal transitioned_halfway

var skip_emit = false


func transition():
	#在动画里发信号了
	$AnimationPlayer.play("default")
	await transitioned_halfway
	$AnimationPlayer.play_backwards("default")


#切换到某场景
func transition_to_scene(scene_path: String):
	ScreenTransition.transition()
	await ScreenTransition.transitioned_halfway
	get_tree().change_scene_to_file(scene_path)



func emit_transitioned_halfway():
	if skip_emit:
		skip_emit = false
		return
	transitioned_halfway.emit()
