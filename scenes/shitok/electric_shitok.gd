extends Interactable

@export var elevator : Interactable

func interact() -> void:
	if elevator:
		active = false
		elevator.active = true
