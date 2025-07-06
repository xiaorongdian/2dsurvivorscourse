extends Area2D

class_name HurtboxComponent

#击中
signal hited

@export var health_component : Node

#预加载场景，缺点是路径字符串常量是硬编码
var floating_text_scene = preload("res://scenes/ui/floating_text.tscn")


func _ready() -> void:
	area_entered.connect(on_area_entered)


#击中
func on_area_entered(other_area: Node2D):
	if not other_area is HitboxComponent:
		return
	if health_component == null:
		return
	
	var hitbox_component = other_area as HitboxComponent
	health_component.damage(hitbox_component.damage)
	
	#伤害数字场景
	var floating_text = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	
	floating_text.global_position = global_position + (Vector2.UP * 16)
	
	var format_string = "%0.1f"
	#如果是整数则保留整数。
	if round(hitbox_component.damage) == hitbox_component.damage:
		format_string = "%0.0f"
	floating_text.start(format_string % hitbox_component.damage)
	
	hited.emit()
