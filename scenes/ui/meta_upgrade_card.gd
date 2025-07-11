extends PanelContainer
#每张升级能力卡


@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel


func _ready() -> void:
	gui_input.connect(on_gui_input)
	

#构造升级时卡片显示
func set_meta_upgrade(upgrade: MetaUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


#选择卡片
func select_card():
	$AnimationPlayer.play("selected")


#点击事件
func on_gui_input(event: InputEvent):		
	if event.is_action_pressed("left_click"):
		select_card()
		
