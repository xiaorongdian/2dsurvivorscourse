extends PanelContainer
#每张升级能力卡


@onready var name_label: Label = $%NameLabel
@onready var description_label: Label = $%DescriptionLabel
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var purchase_button: Button = %PurchaseButton
@onready var progress_label: Label = %ProgressLabel


var upgrade: MetaUpgrade


func _ready() -> void:
	purchase_button.pressed.connect(on_purchase_pressed)
	gui_input.connect(on_gui_input)
	

#构造升级时卡片显示
func set_meta_upgrade(upgrade_param: MetaUpgrade):
	self.upgrade = upgrade_param
	name_label.text = upgrade_param.title
	description_label.text = upgrade_param.description
	update_progress()


#加入局外升级能力
func update_progress():
	var currency = MetaProgression.save_data["meta_upgrade_currency"] 
	#百分比
	var percent = currency / upgrade.experience_cost
	percent = min(percent, 1)
	progress_bar.value = percent
	#100%之前禁用
	purchase_button.disabled = percent < 1
	progress_label.text = str(currency) + "/" + str(upgrade.experience_cost)
	

#选择卡片
func select_card():
	$AnimationPlayer.play("selected")


#点击事件
func on_gui_input(event: InputEvent):		
	if event.is_action_pressed("left_click"):
		select_card()
		

#购买按钮按下
func on_purchase_pressed():
	if upgrade == null:
		return
	MetaProgression.add_meta_upgrade(upgrade)
	#扣除货币
	MetaProgression.save_data["meta_upgrade_currency"] -= upgrade.experience_cost
	MetaProgression.save()
	get_tree().call_group("meta_upgrade_card", "update_progress")
	$AnimationPlayer.play("selected")
	
