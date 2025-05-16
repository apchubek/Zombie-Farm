extends StaticBody3D
class_name HitBox

@export_enum('head', 'body', 'limbs') var type : int 

var owner_

func _ready() -> void:
	set_collision_layer_value(1, false)
	set_collision_mask_value(1, false)
	
	set_collision_layer_value(8, true)
	#set_collision_mask_value(8, true)
	
	owner_ = get_owner()

func get_hit(damage : float = 0.0):
	owner_.get_hit(damage, type)
