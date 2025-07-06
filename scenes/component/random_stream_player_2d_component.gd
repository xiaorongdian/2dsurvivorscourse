extends AudioStreamPlayer2D
#音乐播放组件

#音乐属性
@export var streams: Array[AudioStream]


#随机播放
func play_random():
	if streams == null || streams.size() == 0:
		return
	
	stream = streams.pick_random()
	play()
