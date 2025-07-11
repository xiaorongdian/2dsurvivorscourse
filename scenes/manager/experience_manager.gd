extends Node

#经验值变更
signal experience_update(current_experience : float, target_experience : float)
#升级
signal level_up(new_level : int)


const EXPERIENCE_GROW = 5 # 每级经验条增加

var target_experience = 1 
var current_experience = 0
var current_level = 1

func _ready():
	#接收信号
	GameEvents.experiecnce_vial_collected.connect(on_experience_vial_collecter)


func increment_experience(number: float):
	current_experience += number
	experience_update.emit(current_experience, target_experience)
	if current_experience == target_experience:
		current_level += 1
		current_experience = 0
		target_experience += EXPERIENCE_GROW
		experience_update.emit(current_experience, target_experience)
		level_up.emit(current_level)

func on_experience_vial_collecter(number: float):
	increment_experience(number)
