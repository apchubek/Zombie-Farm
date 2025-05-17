extends StaticBody3D
class_name Tower

var health : float = 1000.0 :
	set(value):
		health = value
		Global.tower_health_changed.emit(value)
var death : bool = false

func _ready() -> void:
	Global.tower = self

func get_hit(dmg : float = 0.0):
	if death:
		return
	
	health -= dmg
	
	if health < 0:
		death = true
