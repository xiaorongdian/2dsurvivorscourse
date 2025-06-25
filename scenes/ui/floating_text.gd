#受到伤害后显示的数字
extends Node2D


func _ready() -> void:
	pass


func start(text:String):
	$Label.text = text
	
	scale = Vector2.ZERO
	
	var tween = create_tween()
	#并行
	tween.set_parallel()
	
	#向上16像素，持续0.3秒消失到出现
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2.ONE, .3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween.chain()
	
	#向上48像素，持续0.4秒出现到消失
	tween.tween_property(self, "global_position", global_position + (Vector2.UP * 48), .5)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "scale", Vector2.ZERO, .4)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	#串行
	tween.chain()
	
	tween.tween_callback(queue_free)
	
	#缩放动画
	var scale_tween = create_tween()
	scale_tween.tween_property(self, "scale", Vector2.ONE * 1.5, .15)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	scale_tween.tween_property(self, "scale", Vector2.ONE, .15)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
