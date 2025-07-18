extends Node

@export var axe_ability_scene: PackedScene

var base_damage = 10
var additional_damage_percent = 1

var axe_count = 0

func _ready() -> void:
	#一有这个能力就触发一次
	on_timer_timeout()
	$Timer.timeout.connect(on_timer_timeout)
	GameEvents.ability_upgrade_added.connect(on_ability_upgrade_added)

	
func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if(null == player):
		return
	
	var foreground = get_tree().get_first_node_in_group("foreground_layer") as Node2D
	if foreground == null:
		return
	
	var axe_instance = axe_ability_scene.instantiate() as Node2D
	foreground.add_child(axe_instance)
	axe_instance.global_position = player.global_position
	axe_instance.hitbox_component.damage = base_damage * additional_damage_percent
	
	$Timer.wait_time = 3.5 / (axe_count + 1)


#升级斧时
func on_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	if upgrade.id == "axe_damage":
		additional_damage_percent = 1 + (current_upgrades["axe_damage"]["quantity"] * .1)
	elif upgrade.id == "axe_count":
		axe_count = current_upgrades["axe_count"]["quantity"]
		on_timer_timeout()
