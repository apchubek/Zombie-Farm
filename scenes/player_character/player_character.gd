extends CharacterBody3D
class_name Player

@export var ui_enabled : bool = true
@export var ui : CanvasLayer
@export var max_health : = 100
@export var sens : float = 1.0 :
	set(value):
		sens = value * 0.001
@export var move_speed : float = 5.0
@export var gravity: float = 30.0
@export var jump_force: float = 8.0

@onready var camera_pivot: Marker3D = $camera_pivot
@onready var camera_3d: Camera3D = $camera_pivot/camera_body/Camera3D
@onready var hand: Node3D = $camera_pivot/weapon_recoil/hand
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var raycast : RayCast3D
@export var interact_raycast : RayCast3D

@export var weapons : Dictionary = {
	"glock17":{
		'add_with_spawn' : true,
		"scene_path": "res://scenes/glock17/glock_17.tscn"
	}
}

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
	if animation_player:
		animation_player.play(&'appear_anim')
	
	sens = AppSettings.get_config_input_events('MouseSensitivity', 1.0)
	
	Global.tower_health_changed.connect(func check_lose(_health : int):
		if _health <= 0:
			animation_player.play(&"level_1_lose")
			animation_player.process_mode = Node.PROCESS_MODE_ALWAYS
			
			process_mode = Node.PROCESS_MODE_DISABLED
			set_process_input(false)
		)
	animation_player.animation_finished.connect(func change_scene(animation_name : StringName):
		if animation_name == &"level_1_lose":
			get_tree().change_scene_to_file("res://scenes/locations/level_2.tscn")
		)
	
	if ui:
		ui.change_visibility_game_control(ui_enabled)
	
	for item in weapons:
		if weapons[item].add_with_spawn:
			var instance = load(weapons[item].scene_path).instantiate()
			
			instance.player = self
			instance.raycast = raycast
			
			hand.add_child(instance, true)

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
	
	if not interact_raycast:
		return
	
	if interact_raycast.is_colliding():
		var collider : PhysicsBody3D = interact_raycast.get_collider()
		
		if collider is Interactable:
			if ui :
				ui.procces_change_interact_hint_visibility(collider.active)
			
			if Input.is_action_just_pressed(&"interact"):
				collider.interact()
		else:
			if ui:
				ui.procces_change_interact_hint_visibility(false)
	else:
		if ui:
			ui.procces_change_interact_hint_visibility(false)

func get_hit(dmg : float):
	health -= dmg
	if health <= 0:
		get_tree().quit()
