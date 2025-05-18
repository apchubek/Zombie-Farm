extends Node3D
class_name AmmoSpawner

@export var scene_limit_onetime : int = 5
@export var spawn_list : Array[PackedScene] = [preload("res://scenes/farm_scenes/bullet_box.tscn")]
@onready var spawns : Array[Node] = get_children(true)

var ammo_parent_node : Node3D = Node3D.new()
var previous_spawn_index : int = -1

func _ready() -> void:
	await get_owner().ready
	ammo_parent_node.name = "WrenchRoot"
	
	add_sibling(ammo_parent_node, true)
	
	Global.game_level.hour_changed.connect(hour_changed)

func hour_changed(_hour : int):
	if ammo_parent_node.get_child_count() >= scene_limit_onetime:
		return
	
	var random_index : int = randi() % (spawns.size())
	var max_tries : int = 5
	var tries : int = 0
	
	while random_index == previous_spawn_index and tries < max_tries:
		random_index = randi() % (spawns.size() - 1)
		tries += 1
	
	var instance = spawn_list.pick_random().instantiate()
	instance.global_transform = spawns[random_index].global_transform
	ammo_parent_node.add_child(instance)
	
	previous_spawn_index = random_index
