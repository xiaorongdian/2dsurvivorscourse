extends Node2D


func _ready() -> void:
	$Area2D.area_entered.connect(on_area_enter)
	

func on_area_enter(other_area: Area2D):
	#发信号
	GameEvents.emit_experiecnce_vial_collecter(1)
	queue_free()
