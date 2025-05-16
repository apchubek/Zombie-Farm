extends Node3D
class_name RecoilApplier

var camera_current_rotation : Vector3
var camera_target_rotation : Vector3
var camera_past_target : Vector3

var camera_snappiness : Vector3 
var camera_return_speed : Vector3 

var body_current_rotation : Vector3
var body_target_rotation : Vector3
var body_past_target : Vector3

var body_snappiness : Vector3 
var body_return_speed : Vector3 

var weapon_current_translation : Vector3
var weapon_target_translation : Vector3
var weapon_past_translation_target : Vector3

var weapon_current_rotation : Vector3
var weapon_target_rotation : Vector3
var weapon_past_target : Vector3

@onready var weapons = $hand
@onready var camera_body = $"../camera_body"

func _ready() -> void:
	await get_owner().ready
	#EventBus.weapon_manual_spread.connect(func x(rot : Vector3):
		#spread(rot)
		#)
	
	Global.weapon_recoil.connect(
		func (camera_kick : Vector3, _snappines : float, _return_speed): 
			camera_target_rotation = camera_kick
			camera_snappiness = Vector3(_snappines,_snappines,_snappines) 
			camera_return_speed = Vector3(_return_speed, _return_speed, _return_speed) 
			) 

func _process(_delta: float) -> void:
	apply_recoil(true,camera_target_rotation, camera_current_rotation, camera_past_target, camera_return_speed, camera_snappiness)
	apply_recoil(false,body_target_rotation, body_current_rotation, body_past_target, body_return_speed, body_snappiness)

func apply_recoil(camera : bool,target_rotation : Vector3, current_rotation : Vector3, past_target : Vector3, return_speed : Vector3, snappiness : Vector3):
	var fixed_delta : float = Global.fixed_delta_procces
	
	if camera:
		camera_target_rotation.x = lerp(target_rotation.x, 0.0, return_speed.x * fixed_delta)
		camera_target_rotation.y = lerp(target_rotation.y, 0.0, return_speed.y * fixed_delta)
		camera_target_rotation.z = lerp(target_rotation.z, 0.0, return_speed.z * fixed_delta)
		
		camera_current_rotation.x = lerp(current_rotation.x,target_rotation.x, snappiness.x * fixed_delta)
		camera_current_rotation.y = lerp(current_rotation.y,target_rotation.y, snappiness.y * fixed_delta)
		camera_current_rotation.z = lerp(current_rotation.z, target_rotation.z, snappiness.z * fixed_delta)
		
		if target_rotation < past_target:
			rotation_degrees = target_rotation
		else:
			rotation_degrees.x = lerp(rotation_degrees.x, current_rotation.x, fixed_delta * snappiness.x)
			rotation_degrees.y = lerp(rotation_degrees.y, current_rotation.y, fixed_delta * snappiness.y)
			rotation_degrees.z = lerp(rotation_degrees.z, current_rotation.z, fixed_delta * snappiness.z)
			
			weapons.rotation_degrees.x = lerp(rotation_degrees.x,current_rotation.x / 2, fixed_delta * snappiness.x) 
			weapons.rotation_degrees.y = lerp(rotation_degrees.y,current_rotation.y / 2, fixed_delta * snappiness.y)
			weapons.rotation_degrees.z = lerp(rotation_degrees.z,current_rotation.z / 2, fixed_delta * snappiness.z) 
	else:
		body_target_rotation.x = lerp(target_rotation.x, 0.0, return_speed.x * fixed_delta)
		body_target_rotation.y = lerp(target_rotation.y, 0.0, return_speed.y * fixed_delta)
		body_target_rotation.z = lerp(target_rotation.z, 0.0, return_speed.z * fixed_delta)
		
		body_current_rotation.x = lerp(current_rotation.x,target_rotation.x, snappiness.x * fixed_delta)
		body_current_rotation.y = lerp(current_rotation.y,target_rotation.y, snappiness.y * fixed_delta)
		body_current_rotation.z = lerp(current_rotation.z,target_rotation.z, snappiness.z * fixed_delta)
		
		camera_body.rotation_degrees.x = lerp(rotation_degrees.x, current_rotation.x, fixed_delta * snappiness.x)
		camera_body.rotation_degrees.y = lerp(rotation_degrees.y, current_rotation.y, fixed_delta * snappiness.y)
		camera_body.rotation_degrees.z = lerp(rotation_degrees.z, current_rotation.z, fixed_delta * snappiness.z)


func get_spread_factor() -> float:
	return camera_current_rotation.length_squared()
