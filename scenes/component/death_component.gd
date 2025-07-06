extends Node2D

#健康组件
@export var health_component: Node
#纹理
@export var sprite: Sprite2D


func _ready() -> void:
	$GPUParticles2D.texture = sprite.texture
	health_component.died.connect(on_died)


func on_died():
	if owner == null || not owner is Node2D:
		return
	#var spawn_position = owner.global_position
	#因为把自己移除后就不能get_tree了，所以先获取到tree
	var entities = get_tree().get_first_node_in_group("entities_layer")
	#将自己的父节点重新设置成 entities，两种方式self.reparent(entities)是4.0才有的新方法
	self.reparent(entities)
	#get_parent().remove_child(self)
	#entities.add_child(self)
	#global_position = spawn_position
	$AnimationPlayer.play("defalut")
	$HitRandomAudioPlayerComponent.play_random()
