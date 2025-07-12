extends Node
#经验瓶掉落

#血条组件
@export var health_component: Node
#经验瓶
@export var vail_scene: PackedScene
#掉落概率
@export_range(0,1) var drop_percent: float = .5

func _ready() -> void:
	#血条组件连接信号到on_died
	(health_component as HealthComponent).died.connect(on_died)
	
	
func on_died():
	#调整掉落概率，加上局外成长
	var adjusted_drop_percent = drop_percent
	var experience_gain_upgrade_count = MetaProgression.get_upgrade_count("experience_gain")
	if experience_gain_upgrade_count > 0:
		adjusted_drop_percent += .1
		
	if(randf() > adjusted_drop_percent):
		return
	if vail_scene == health_component:
		return
	if not owner is Node2D:
		return
	#怪当前位置
	var spawn_position = (owner as Node2D).global_position
	var vail_scene_instance = vail_scene.instantiate() as Node2D
	#用下面的方法报错
	#owner.get_parent().add_child(vail_scene_instance)
	#用下面的方法不好使
	#owner.get_parent().set_deferred("add_child", vail_scene_instance)
	#用下面的方法不报错
	#owner.get_parent().call_deferred("add_child", vail_scene_instance)
	var entities_layer = get_tree().get_first_node_in_group("entities_layer")
	entities_layer.call_deferred("add_child", vail_scene_instance)
	vail_scene_instance.global_position = spawn_position
