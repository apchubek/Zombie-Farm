extends SpotLight3D

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if Input.is_action_just_pressed("flashlight"):
			visible = !visible
