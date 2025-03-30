extends CanvasLayer

@export var upgrade_scene : PackedScene

@onready var card_container: HBoxContainer = $%CardContainer


func _ready() -> void:
	#暂停场景树
	get_tree().paused = true


func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var card_instance = upgrade_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
	
