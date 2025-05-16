extends Node3D

@export var sway_multiplier = 3
@export var sway_speed = 2

@export var rotation_multiplier = 5

var mouse_speed : float 
var mouse_vector : Vector2 

func _ready():
	mouse_speed = 0.008

func _input(event):
	if event is InputEventMouseMotion:
		mouse_vector = (event.relative * mouse_speed)

func _process(_delta):
	var input_dir = Input.get_vector("left", "right", "up", "down")
	
	rotation_degrees = lerp(rotation_degrees, Vector3((mouse_vector.y * sway_multiplier * 2) * sway_multiplier, (mouse_vector.x * sway_multiplier * 2) * sway_multiplier, (-input_dir.x * rotation_multiplier) + mouse_vector.x  * sway_multiplier * 5), (sway_speed * 5) * Global.fixed_delta_procces)  
	mouse_vector = Vector2.ZERO
