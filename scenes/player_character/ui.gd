extends CanvasLayer

@onready var player_health_label: Label = %player_health_label
@onready var tower_health_label: Label = %tower_health_label
@onready var ammo_label: Label = %ammo_label

const PAUSE_MENU = preload("res://scenes/overlaid_menus/pause_menu.tscn")

var pause_menu 

func _ready() -> void:
	get_owner().health_changed.connect(func update_player_health(health : float):
		player_health_label.text = "health : %s" %[int(health)]
		)
	Global.tower_health_changed.connect(func update_tower_health(health : float):
		tower_health_label.text = "tower health : %s" %[int(health)]
		)
	Global.update_weapon_ui.connect(func update_tower_health(clip : int, ammo : int):
		ammo_label.text = "%s/%s" %[clip, ammo]
		)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape"):
		if not pause_menu:
			pause_menu = PAUSE_MENU.instantiate()
			add_child(pause_menu) 
