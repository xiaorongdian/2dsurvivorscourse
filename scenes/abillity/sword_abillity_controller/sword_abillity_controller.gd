extends Node

@export var sword_abillity: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Timer.start()
	$Timer.timeout.connect(on_timer_timeout)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_timer_timeout():
	print("timeout")
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(null == player):
		return
	
	var sword_instance = sword_abillity.instantiate() as Node2D
	player.get_parent().add_child(sword_instance)
	sword_instance.global_position = player.global_position
	
	
