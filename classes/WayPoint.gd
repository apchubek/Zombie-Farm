extends TextureRect
class_name WayPoint

@onready var camera: Camera3D = get_viewport().get_camera_3d()
#@export var shrink_distance : float = 10.0
#@export var minimum_scale : float = 2
#@export var texture_rect : TextureRect

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _process(_delta: float) -> void:
	global_position = camera.unproject_position(owner.global_position)
	visible = not camera.is_position_behind(owner.global_position)
	
	#var _scale : float = max(minimum_scale, owner.global_position.distance_to(camera.global_position) / 50.0)
	#scale = Vector2(_scale, _scale)
	#if texture_rect:
		#texture_rect.position = (texture_rect.size / 2.0) * scale
