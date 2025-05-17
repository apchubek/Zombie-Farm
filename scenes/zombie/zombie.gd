extends CharacterBody3D

@export var max_health : float = 125
@export var dmg : float = 10
@export var collision_shape : CollisionShape3D
@export var skeleton : Skeleton3D
@export var head_attachment : BoneAttachment3D

@export var disabled: bool = false

@export var moaning_sounds : AudioStreamPlayer3D
@export var death_sound : AudioStreamPlayer3D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var zombie_mesh: MeshInstance3D = $model/zombie_low_poly_animated/Armature/Skeleton3D/Zombie
@onready var area_3d: Area3D = $Area3D


enum target_types {player, tower}

var target_type : target_types = target_types.player
var target_node : Node3D

var health : float = max_health
var speed : float = 3.0

var is_dead : bool = false
var is_attacking : bool = false
var is_spawning : bool = true

var path : Vector3

var attack_target : Node3D
var hitboxes : Array

var random_tick : int = 30
var tick : int = 1

func _enter_tree() -> void:
	if disabled:
		return
	visible = false


func _ready() -> void:
	if disabled:
		return
	
	for x in 3:
		await get_tree().physics_frame
	
	hitboxes = find_children('*','HitBox')
	
	var rng_int : int = randi_range(0, 1)
	
	if bool(rng_int):
		target_node = Global.player
	else:
		target_node = Global.tower
	
	animation_tree.set(&"parameters/die_blend/blend_amount", 0.0)
	if navigation_agent_3d: navigation_agent_3d.velocity_computed.connect(_set_computed_velocity)
	
	animation_tree.animation_finished.connect(reset_state)
	
	animation_tree[&"parameters/spawn_animation/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	visible = true

func _physics_process(_delta: float) -> void:
	if disabled:
		return
	
	if is_dead or is_spawning:
		return
	
	if tick == 0:
		random_tick = randi_range(360, 1080)
	
	tick += 1
	if tick >= random_tick:
		tick = 0
		if moaning_sounds:
			moaning_sounds.play()
	
	if attack_target:
		if not is_attacking:
			attack()
	
	if not is_attacking:
		if area_3d.has_overlapping_bodies():
			for body in area_3d.get_overlapping_bodies():
				_on_area_3d_body_entered(body)
	
	if is_attacking:
		return
	
	if target_node:
		navigation_agent_3d.target_position = target_node.global_position
	
	path = navigation_agent_3d.get_next_path_position()
	
	update_velocity((path - global_position).normalized() * speed)
	
	if animation_tree:
		animation_tree.set(&"parameters/walk_blend/blend_amount", get_real_velocity().length() / speed)
	
	move_and_slide()
	update_rotation()

func update_rotation():
	var dir = (path - global_position).normalized()
	
	var target_rotation = Quaternion(Vector3.UP, atan2(-dir.x, -dir.z))
	var current_rotation = global_transform.basis.get_rotation_quaternion()
	
	var new_rotation = current_rotation.slerp(target_rotation, 0.1)
	var new_transform = global_transform
	
	new_transform.basis = Basis(new_rotation)
	global_transform = new_transform

func update_velocity(new_velocity : Vector3):
	if navigation_agent_3d:
		if navigation_agent_3d.avoidance_enabled:
			navigation_agent_3d.set_velocity(new_velocity)
		else:
			velocity = new_velocity

func _set_computed_velocity(safe_velocity : Vector3):
	velocity = safe_velocity

func get_hit(damage : float = 0.0, type = 1):
	if is_dead:
		return
	
	if type == 0:
		health -= health + 1
	else:
		health -= damage
	
	if health < 0:
		die()
	
	if type == 0:
		if skeleton:
			var head_id : int = skeleton.find_bone('head')
			
			if head_id:
				if head_attachment:
					head_attachment.queue_free()
					await get_tree().physics_frame
				skeleton.set_bone_pose_scale(head_id, Vector3.ZERO)

func die():
	if death_sound:
		death_sound.play()
	for hitbox in hitboxes:
		hitbox.queue_free()
	
	Global.score += 100
	Global.killed_zombie += 1
	
	if skeleton:
		skeleton.physical_bones_start_simulation()
	
	if animation_tree:
		var tween : Tween = get_tree().create_tween()
		tween.tween_property(animation_tree,"parameters/die_blend/blend_amount", 1.0, 0.5)
		
		tween.finished.connect(func ():
			var _tween : Tween = get_tree().create_tween()
			zombie_mesh.cast_shadow = GeometryInstance3D.SHADOW_CASTING_SETTING_OFF
			_tween.tween_property(zombie_mesh,"transparency", 1.0, 3.0)
			_tween.play()
			await _tween.finished
			
			queue_free()
			)
		collision_shape.disabled = true
		is_dead = true
		tween.play()

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player or body is Tower:
		if body is Tower:
			if body.global_position.distance_to(global_position) > 1.5:
				return  
		
		attack()
		
		attack_target = body

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is Player or body is Tower:
		attack_target = null

func attack():
	is_attacking = true
	animation_tree[&"parameters/attack_shot/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	
	await get_tree().create_timer(0.6, false).timeout
	
	if attack_target:
		var dmg_mult : float = 1.0
		
		if attack_target is Tower:
			dmg_mult = 5.0
		
		attack_target.get_hit(dmg * dmg_mult)

func reset_state(anim : String):
	if anim == "animation_library/Attack1":
		is_attacking = false
	if anim == "animation_library/Death1":
		is_spawning = false
