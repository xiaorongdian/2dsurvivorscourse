extends Node

var current_experience = 0

func _ready():
	#接收信号
	GameEvents.experiecnce_vial_collecter.connect(on_experience_vial_collecter)

func increment_experience(number: int):
	current_experience += number
	print(current_experience)


func on_experience_vial_collecter(number: int):
	increment_experience(number)
