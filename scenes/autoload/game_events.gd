extends Node
#全局事件

#经验瓶掉落信号
signal experiecnce_vial_collecter(number: int)
#能力添加信号
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)


func emit_experiecnce_vial_collecter(number: int):
	experiecnce_vial_collecter.emit(number)
	
func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)
