extends Interactable

func interact() -> void:
	if Global.tower:
		Global.tower.health += 50
	
	get_parent().queue_free()
