extends Node
#经验瓶掉落

#血条组件
@export var health_component: Node
#经验瓶
@export var vail_scene: PackedScene
#掉落概率
@export_range(0,1) var exp_range: float = .5

func _ready() -> void:
	#血条组件连接信号到on_died
	(health_component as HealthComponent).died.connect(on_died)
	
	
func on_died():
	if(randf() > exp_range):
		return
	if vail_scene == health_component:
		return
	if not owner is Node2D:
		return
	#怪当前位置
	var spawn_position = (owner as Node2D).global_position
	var vail_scene = vail_scene.instantiate() as Node2D
	#用下面的方法报错
	#owner.get_parent().add_child(vail_scene)
	#用下面的方法不好使
	#owner.get_parent().set_deferred("add_child", vail_scene)
	#用下面的方法不报错
	owner.get_parent().call_deferred("add_child", vail_scene)
	vail_scene.global_position = spawn_position
