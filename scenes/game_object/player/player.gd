extends CharacterBody2D
class_name Player

const MAX_SPEED = 125
const JIA_SU_PING_HUA = 25 #角色移动缓冲加速粒度
var number_colliding_bodies = 0 #当前有几个敌人在碰撞区内

#受伤定时器
@onready var damage_interval_timer = $DamageIntervalTimer
#hp组件
@onready var health_component = $HealthComponent
#hpUI
@onready var health_bar = $HealthBar
#能力
@onready var abilities = $Abilitise
#动画
@onready var animation_player = $AnimationPlayer
#翻转
@onready var visuals = $Visuals


func _ready() -> void:
	$CollisionArea2D.body_entered.connect(on_body_entered)
	$CollisionArea2D.body_exited.connect(on_body_exited)
	damage_interval_timer.timeout.connect(on_damage_interval_timer_timeout)
	health_component.health_changed.connect(on_health_changed)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)
	update_health_display()


func _process(delta: float) -> void:
	var movement_vector = get_movment_vector()
	var direction = movement_vector.normalized()
	var target_velocity = direction * MAX_SPEED
	#平滑跟随移动
	velocity = velocity.lerp(target_velocity, 1 - exp(-delta * JIA_SU_PING_HUA))
	
	move_and_slide()
	
	if movement_vector.x != 0 || movement_vector.y != 0:
		animation_player.play("walk")
	else:
		animation_player.play("RESET")
	
	var move_sign = sign(movement_vector.x)
	if move_sign == 0:
		#如果x轴不移动则保持朝向
		return
	else:
		#x轴正向移动就是1,1 反方向就是 -1,1 ，反方向纹理和动画就翻转
		visuals.scale = Vector2(move_sign, 1)
		
		
func get_movment_vector():
	var x_movement = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	var y_movement = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_movement, y_movement)
	

#检查是否受伤害
func check_deal_damage():
	if number_colliding_bodies == 0 || !damage_interval_timer.is_stopped():
		return
	health_component.damage(1)
	damage_interval_timer.start()


#更新一下hp显示
func update_health_display():
	health_bar.value = health_component.get_health_percent()


#当身体进入碰撞
func on_body_entered(other_body: Node2D):
	#碰撞取内敌人+1
	number_colliding_bodies += 1
	check_deal_damage()


#当身体离开碰撞
func on_body_exited(other_body: Node2D):
	number_colliding_bodies -= 1
	check_deal_damage()
	

func on_damage_interval_timer_timeout():
	check_deal_damage()


#当hp发生变化
func on_health_changed():
	update_health_display()


#能力增加
func on_ability_upgrade_added(ability_upgrade: AbilityUpgrade, currect_upgrades: Dictionary):
	#如果不是一个能力，而是一个普通的升级，则返回
	if not ability_upgrade is Ability:
		return
	#转成Ability类
	var ability = ability_upgrade as Ability
	#将能力加入到能力集合下。
	abilities.add_child(ability.ability_controller_scene.instantiate())
	
