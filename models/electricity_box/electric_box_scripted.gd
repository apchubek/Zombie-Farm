extends StaticBody3D
class_name Tower

var health : float = 1000.0 :
	set(value):
		health = value
		Global.tower_health_changed.emit(value)

func _ready() -> void:
	Global.tower = self

func get_hit(dmg : float = 0.0):
	health -= dmg
