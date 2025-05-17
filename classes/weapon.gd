extends Node3D

@export_category("Stats")
@export var damage : float = 40.0
@export var fire_rate : int = 300
@export var hold_to_fire : bool = false
@export var recoil : Vector3
@export var recoil_snappines : float = 5.0
@export var recoil_return_speed : float = 5.0 
@export var clip_size : int = 14
@export var ammo_size : int = 140

@export_category("Sounds")
@export var fire_sound : AudioStreamPlayer3D

@export_group("Animations")
@export var animation_player : AnimationPlayer
@export var animation_tree : AnimationTree
@export var fire_anim : String
@export var idle_anim : String
@export var walk_anim : String
@export var reload_anim : String
@export var reload_fast_anim : String

var timer : Timer = Timer.new()
var raycast : RayCast3D
var player : Player
var is_reloading : bool = false

var clip = clip_size:
	set(value):
		Global.update_weapon_ui.emit(value, ammo)
		clip = value
var ammo = ammo_size:
	set(value):
		Global.update_weapon_ui.emit(clip, value)
		ammo = value

const BLOOD_SPLATTER = preload("res://scenes/bullet_particles/BloodSplatter.tscn")

func _ready() -> void:
	add_child(timer) 
	
	timer.wait_time = 60.0  / fire_rate
	timer.one_shot = true
	
	animation_tree.animation_finished.connect(func (animation : String):
		if animation in [reload_anim, reload_fast_anim]:
			is_reloading = false
			)

func _physics_process(delta: float) -> void:
	if player:
		animation_tree['parameters/idle_walk_blend/blend_amount'] = lerp(animation_tree['parameters/idle_walk_blend/blend_amount'], player.get_real_velocity().length() / player.move_speed, 5 * delta)

func _process(_delta: float) -> void:
	if not timer.is_stopped():
		return
	
	if Input.is_action_just_pressed("reload"):
		
		if clip == clip_size:
			return
		
		if clip > 0:
			animation_tree['parameters/reload_fast_shot/request'] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		else:
			animation_tree['parameters/reload_full_shot/request'] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
		is_reloading = true
		
		var need_to_load : int = clip_size - clip  
		if need_to_load > ammo:
			clip += ammo
			ammo = 0
		else:
			clip += need_to_load
			ammo -= need_to_load
	
	if hold_to_fire:
		if Input.is_action_pressed("mouse_1"):
			fire()
	else:
		if Input.is_action_just_pressed("mouse_1"):
			fire()

func fire():
	if not clip > 0:
		return
	if is_reloading:
		return
	
	timer.start()
	clip -= 1
	
	if raycast.is_colliding():
		var coll : PhysicsBody3D = raycast.get_collider()
		if coll.has_method(&"get_hit"):
			coll.get_hit(damage)
			if coll is HitBox:
				var instance_blood = BLOOD_SPLATTER.instantiate()
				Global.add_sibling(instance_blood)
				instance_blood.global_position = raycast.get_collision_point()
	
	var recoil_fin : Vector3
	 
	recoil_fin.x = randf_range(recoil.x, recoil.x * 1.5)
	recoil_fin.y = randf_range(-recoil.y, recoil.y)
	recoil_fin.z = randf_range(-recoil.z, recoil.z)
	
	Global.weapon_recoil.emit(recoil_fin, recoil_snappines, recoil_return_speed)
	
	animation_tree['parameters/fire_shot/request'] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	
	if fire_sound:
		fire_sound.play()
