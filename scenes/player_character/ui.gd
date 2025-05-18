extends CanvasLayer

@onready var player_health_label: Label = %player_health_label
@onready var tower_health_label: Label = %tower_health_label
@onready var ammo_label: Label = %ammo_label
@onready var score_label: Label = %score_label
@onready var time_label: Label = %time_label

@onready var previous_health : float = get_owner().health
@onready var blood_overlay_animation_player: AnimationPlayer = %blood_overlay_animation_player
@onready var e_button_hint: Label = $E_button_hint

@onready var control: Control = $control

const PAUSE_MENU = preload("res://scenes/overlaid_menus/pause_menu.tscn")

var pause_menu 
func _ready() -> void:
	get_owner().health_changed.connect(func update_player_health(health : float):
		player_health_label.text = "health : %s" %[int(health)]
		if health < previous_health:
			blood_overlay_animation_player.play('fade')
		)
	Global.tower_health_changed.connect(func update_tower_health(health : float):
		tower_health_label.text = "tower health : %s" %[int(health)]
		)
	Global.update_weapon_ui.connect(func update_score_health(clip : int, ammo : int):
		ammo_label.text = "%s/%s" %[clip, ammo]
		)
	Global.update_score_ui.connect(func update_score_health(score : int):
		score_label.text = "score : %s" %[score]
		)
	Global.game_time_updated.connect(func(hour: int):
		time_label.text = "Time : %02d:00" % hour
)

func change_visibility_game_control(_visible : bool):
	control.visible = _visible

func procces_change_interact_hint_visibility(_visible : bool):
	e_button_hint.visible = _visible

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if not pause_menu:
			pause_menu = PAUSE_MENU.instantiate()
			add_child(pause_menu) 
