extends Node
#被攻击命中时闪烁白色纹理（着色器） 着色器是属于sprite纹理精灵的

#生命组件
@export var health_component: Node
#纹理精灵组件
@export var sprite: Sprite2D
#着色器
@export var hit_flash_material : ShaderMaterial

#击中时动画
var hit_flash_tween:Tween


func _ready() -> void:
	#接收信号
	health_component.health_decreased.connect(on_health_decreased)
	sprite.material = hit_flash_material
	
#当生命发生变更
func on_health_decreased():
	#如果我们有一个动画且有效的，那我们跳过本次动画
	if hit_flash_tween != null && hit_flash_tween.is_valid():
		#终止补间操作
		hit_flash_tween.kill()
	#先变白，再逐渐恢复0
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	hit_flash_tween = create_tween()
	#"shader_parameter/lerp_percent" 属性存在于精灵纹理上
	hit_flash_tween.tween_property(sprite.material, "shader_parameter/lerp_percent" ,0.0, .3)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	
