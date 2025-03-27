extends CanvasLayer
#经验条ui

@export var experience_manager : Node

@onready var progress_bar = $MarginContainer/ProgressBar


func _ready() -> void:
	experience_manager.experience_update.connect(on_experence_update)


func on_experence_update(currect_experience: float, target_experience : float) -> void:
	var percent: float = currect_experience / target_experience
	progress_bar.value = percent
