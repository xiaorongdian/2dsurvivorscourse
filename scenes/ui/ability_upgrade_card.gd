extends PanelContainer

signal selected
@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel



func _ready() -> void:
	gui_input.connect(on_gui_input)

#构造升级时卡片显示
func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


func on_gui_input(event: InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
	
