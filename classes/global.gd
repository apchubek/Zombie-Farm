extends Node

var player : Player
var ui : CanvasLayer
var tower : Tower

var score : int = 0
var killed_zombie : int = 0 

var fixed_delta_procces : float = 0.0

@warning_ignore("unused_signal")
signal tower_health_changed
@warning_ignore("unused_signal")
signal weapon_recoil

@warning_ignore("unused_signal")
signal update_weapon_ui

func _process(delta: float) -> void:
	fixed_delta_procces = min(delta, 0.0166)
