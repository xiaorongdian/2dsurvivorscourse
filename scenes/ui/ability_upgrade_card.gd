extends PanelContainer
#每张升级能力卡

signal selected
@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel

#控制一下在播放动画时卡片禁用
var disabled = false


func _ready() -> void:
	gui_input.connect(on_gui_input)
	mouse_entered.connect(on_mouse_entered)
	

#播放卡片出现的动画 delay延迟多少秒
func play_in(delay: float = 0):
	#先透明
	modulate = Color.TRANSPARENT
	#异步
	await get_tree().create_timer(delay).timeout
	$AnimationPlayer.play("in")


#播放舍弃动画
func play_discard():
	$AnimationPlayer.play("discard")
	

#构造升级时卡片显示
func set_ability_upgrade(upgrade: AbilityUpgrade):
	name_label.text = upgrade.name
	description_label.text = upgrade.description


#选择卡片
func select_card():
	disabled = true
	$AnimationPlayer.play("selected")
	
	for other_card in get_tree().get_nodes_in_group("upgrade_card"):
		if other_card == self:
			continue
		else:
			other_card.play_discard()
			
	#等动画播放完
	await $AnimationPlayer.animation_finished
	selected.emit()


#点击事件
func on_gui_input(event: InputEvent):
	if disabled:
		return
		
	if event.is_action_pressed("left_click"):
		select_card()
		
		
#鼠标进入事件关联方法
func on_mouse_entered():
	if disabled:
		return
	$HoverAnimationPlayer.play("hover")
