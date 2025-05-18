extends Interactable

@export var bullets : int = 54

func interact() -> void:
	if not Global.player:
		return
	
	for weapon in Global.player.weapons_list:
		weapon.ammo += bullets
	
	get_parent().queue_free()
