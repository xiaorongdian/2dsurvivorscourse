extends PanelContainer

signal selected
@onready var name_label = $%NameLabel
@onready var description_label = $%DescriptionLabel



func _ready() -> void:
	gui_input.connect(on_gui_input)

#升级时传过来升的是哪个
func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label = upgrade.name
	description_label = upgrade.description


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
	
