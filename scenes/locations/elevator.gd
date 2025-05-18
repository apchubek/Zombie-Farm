extends Interactable

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var elevator_sound: AudioStreamPlayer3D = $ElevatorSound

func _init() -> void:
	active = false

func interact() -> void:
	if active:
		elevator_sound.play()
		animation_player.play(&'end_animation')
		await animation_player.animation_finished
		get_tree().change_scene_to_file('res://scenes/credits.tscn')
