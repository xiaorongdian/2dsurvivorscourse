extends AudioStreamPlayer
#音乐播放组件 跟位置没关系

#音乐组
@export var streams: Array[AudioStream]
#音调
@export var random_pitch = true
@export var main_pitch = .9
@export var max_pitch = 1.1



#随机播放
func play_random():
	if streams == null || streams.size() == 0:
		return
	
	if random_pitch:
		pitch_scale = randf_range(main_pitch, max_pitch)
	else:
		pitch_scale = 1
	
	stream = streams.pick_random()
	play()
