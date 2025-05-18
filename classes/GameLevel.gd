extends Node3D
class_name GameLevel

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var won_label: Label = $Won_Label

const GAME_HOUR_DURATION := 45.0 
const TOTAL_GAME_HOURS := 6 # от 00:00 до 06:00

var current_hour := 0:
	set(value):
		current_hour = value
		hour_changed.emit(value)

var timer := 0.0

signal hour_changed

func _ready() -> void:
	Global.game_level = self
	ProjectMusicController.stop()

func _process(delta):
	timer += delta
	if timer >= GAME_HOUR_DURATION:
		timer -= GAME_HOUR_DURATION
		current_hour += 1
		print("Game hour: ", current_hour, ":00")
		Global.game_time_updated.emit(current_hour)

		if current_hour >= TOTAL_GAME_HOURS:
			end_night()

func end_night() -> void:
	set_process(false) 
	print("6:00 reached, playing end animation...")
	$Won_Label.visible = true
	animation_player.play(&'win_level')
	await animation_player.animation_finished
	
	get_tree().change_scene_to_file('res://scenes/credits.tscn')
