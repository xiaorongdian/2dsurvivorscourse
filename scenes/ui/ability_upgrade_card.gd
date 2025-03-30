extends PanelContainer

@onready var name_label = $%NameLabel
@onready var description_label = $%DescriptionLabel

#升级时传过来升的是哪个
func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label = upgrade.name
	description_label = upgrade.description
