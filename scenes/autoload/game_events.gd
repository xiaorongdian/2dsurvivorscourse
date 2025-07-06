extends Node
#全局事件

#经验瓶掉落信号
signal experiecnce_vial_collecter(number: int)
#能力添加信号
signal ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary)
#玩家受伤
signal player_damaged()


#当一个经验瓶掉落后
func emit_experiecnce_vial_collecter(number: int):
	experiecnce_vial_collecter.emit(number)
	
	
#当一个升级能力添加进去
func emit_ability_upgrade_added(upgrade: AbilityUpgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)


#当玩家受伤
func emit_player_damaged():
	player_damaged.emit()
