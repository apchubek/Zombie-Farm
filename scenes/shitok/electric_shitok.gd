extends Interactable

@export var elevator : Interactable
@onready var turn_on_sound: AudioStreamPlayer3D = $TurnOnSound

func interact() -> void:
	if elevator:
		
		active = false
		elevator.active = true
		turn_on_sound.play()
