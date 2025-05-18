extends Node3D
class_name WrenchSpawner

@export var scene_limit_onetime : int = 50
@export var spawn_list : Array[PackedScene] = [preload("res://scenes/farm_scenes/spanner.tscn")]
@onready var spawns : Array[Node] = get_children(true)

var wrench_parent_node : Node3D = Node3D.new()
var previous_spawn_index : int = -1
var previous_tower_health : float = INF

var damage_accumulator: int = 0
const DAMAGE_THRESHOLD: int = 50

func _ready() -> void:
	await get_owner().ready
	wrench_parent_node.name = "WrenchRoot"
	previous_tower_health = Global.tower.health
	
	add_sibling(wrench_parent_node, true)
	
	Global.tower_health_changed.connect(tower_get_hit)

func tower_get_hit(health : float = 0.0):
	if not (previous_tower_health - health) >= 50:
		return
	
	if wrench_parent_node.get_child_count() >= scene_limit_onetime:
		return
	
	var random_index : int = randi() % (spawns.size())
	var max_tries : int = 5
	var tries : int = 0
	
	while random_index == previous_spawn_index and tries < max_tries:
		random_index = randi() % (spawns.size() - 1)
		tries += 1
	
	var instance = spawn_list.pick_random().instantiate()
	instance.global_transform = spawns[random_index].global_transform
	wrench_parent_node.add_child(instance)
	
	previous_spawn_index = random_index
	previous_tower_health = health
