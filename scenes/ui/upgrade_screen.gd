extends CanvasLayer

@export var upgrade_scene : PackedScene

@onready var card_container: HBoxContainer = $%CardContainer

signal upgrade_selected(upgrade: AbilityUpgrade)


func _ready() -> void:
	#暂停场景树
	get_tree().paused = true


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var card_instance = upgrade_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		card_instance.selected.connect(on_upgrade_selected.bind(upgrade))
	
func on_upgrade_selected(upgrade : AbilityUpgrade):
	upgrade_selected.emit(upgrade)
	
	
