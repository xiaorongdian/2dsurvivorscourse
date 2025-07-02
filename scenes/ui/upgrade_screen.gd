extends CanvasLayer

@export var upgrade_scene : PackedScene

@onready var card_container: HBoxContainer = $%CardContainer

signal upgrade_selected(upgrade: AbilityUpgrade)


func _ready() -> void:
	#暂停场景树
	get_tree().paused = true


#能力加到UI中
func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	#延迟
	var delay = 0
	#将能力加到UI
	for upgrade in upgrades:
		var card_instance = upgrade_scene.instantiate()
		#先把能力加场景树中 与设置文本不能颠倒顺序
		card_container.add_child(card_instance)
		#设置文本
		card_instance.set_ability_upgrade(upgrade)
		card_instance.play_in(delay)
		card_instance.selected.connect(on_upgrade_selected.bind(upgrade))
		delay += .2
	
func on_upgrade_selected(upgrade : AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	$AnimationPlayer.play("out")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	queue_free()
	
	
