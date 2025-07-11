extends CanvasLayer

#能力卡
@export var upgrades: Array[MetaUpgrade] = []

#网格盒子
@onready var grid_container = %GridContainer

#场外能力升级卡场景
var meta_upgrade_card_scene = preload("res://scenes/ui/meta_upgrade_card.tscn")


func _ready() -> void:
	for upgrade in upgrades:
		#实例化场景
		var meta_upgrade_card_instance = meta_upgrade_card_scene.instantiate()
		#加到网格里
		grid_container.add_child(meta_upgrade_card_instance)
		meta_upgrade_card_instance.set_meta_upgrade(upgrade)
