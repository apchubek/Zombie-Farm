extends CharacterBody3D
class_name Player

@export var max_health : = 100
@export var sens : float = 1.0 :
	set(value):
		sens = value * 0.001
@export var move_speed : float = 5.0
@export var gravity: float = 30.0
@export var jump_force: float = 8.0

@onready var camera_pivot: Marker3D = $camera_pivot
@onready var camera_3d: Camera3D = $camera_pivot/camera_body/Camera3D

@export var raycast : RayCast3D

var health = max_health:
	set(value):
		health = value
		health_changed.emit(value)

var y_velocity : float = 0.0

signal health_changed

func _ready() -> void:
	Global.player = self
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	sens = sens

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var relative : Vector2 = (event.relative * -1) * sens
		
		camera_pivot.rotate_x(relative.y)
		rotate_y(relative.x) 
		
		camera_pivot.rotation_degrees.x = clamp(camera_pivot.rotation_degrees.x, -80, 80)

func _physics_process(delta: float) -> void:
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	velocity.x = direction.x * move_speed
	velocity.z = direction.z * move_speed

	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_force
		else:
			velocity.y = 0

	move_and_slide()

func get_hit(dmg : float):
	health -= dmg
	if health <= 0:
		get_tree().quit()
