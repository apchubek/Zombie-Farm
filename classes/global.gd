extends Node

var player : Player
var ui : CanvasLayer
var tower : Tower

var score : int = 0 : 
	set(value):
		score = value
		print("Score : ", score)
		update_score_ui.emit(value)
		timer.start()

var killed_zombie : int = 0 : 
	set(value):
		killed_zombie = value
		print("Zombie killed : ", value)
		timer.start() 

var fixed_delta_procces : float = 0.0

@warning_ignore("unused_signal")
signal tower_health_changed
@warning_ignore("unused_signal")
signal update_weapon_ui
@warning_ignore("unused_signal")
signal update_score_ui
@warning_ignore("unused_signal")
signal weapon_recoil

var timer : Timer = Timer.new()

func _ready() -> void:
	add_child(timer)
	timer.timeout.connect(func boba():
		DbHandler.update_total_score_kills_thread(score, killed_zombie)
		)

	
	timer.one_shot = true
	timer.wait_time = 10.0


func _process(delta: float) -> void:
	fixed_delta_procces = min(delta, 0.0166)
