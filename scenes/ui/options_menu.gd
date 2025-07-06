extends CanvasLayer
#设置菜单

#signal back_pressed

#窗口按钮
@onready var window_button: Button = %WindowButton
#音效滑块
@onready var sfx_slider: HSlider = %SfxSlider
#音乐滑块
@onready var music_slider: HSlider = %MusicSlider
@onready var back_button: Button = %BackButton


func _ready():
	back_button.pressed.connect(on_back_pressed)
	window_button.pressed.connect(on_window_button_pressed)
	sfx_slider.value_changed.connect(on_audio_slider_changed.bind("sfx"))
	music_slider.value_changed.connect(on_audio_slider_changed.bind("music"))
	update_display()


#修改显示
func update_display():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		window_button.text = "窗口"
	else:
		window_button.text = "全屏"
	sfx_slider.value = get_bus_volume_percent("sfx")
	music_slider.value = get_bus_volume_percent("music")


#获取音乐总线声音百分比
func get_bus_volume_percent(bus_name: String):
	#总线主键
	var bus_index = AudioServer.get_bus_index(bus_name)
	#音量分贝
	var volume_db = AudioServer.get_bus_volume_db(bus_index)
	#分贝转线性值
	return db_to_linear(volume_db)
	
	
#设置音乐总线声音百分比
func set_bus_volume_percent(bus_name: String, percent: float):
	#总线主键
	var bus_index = AudioServer.get_bus_index(bus_name)
	#线性值转分贝
	var volume_db = linear_to_db(percent)
	print("修改bus_index：",bus_index," 值：", volume_db)
	AudioServer.set_bus_volume_db(bus_index, volume_db)

	
#当口按钮按下
func on_window_button_pressed():
	var mode = DisplayServer.window_get_mode()
	if mode != DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	update_display()


func on_audio_slider_changed(value: float, bus_name: String):
	print("修改bus_name：",bus_name," 值：", value)
	#设置声音，value提前设置正好是百分比
	set_bus_volume_percent(bus_name, value)
	

func on_back_pressed():
	#back_pressed.emit()
	queue_free()
