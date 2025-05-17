extends Node3D

@export var enemy_limit : int = 50
@export var spawn_per_sec : float = 5.0
@export var enemy_list : Array[PackedScene] = [preload("res://scenes/zombie/zombie.tscn")]
@onready var spawns : Array[Node] = get_children(true)

var timer = Timer.new()
var zombie_node : Node3D = Node3D.new()
var previous_spawn_index : int = -1

func _ready() -> void:
	await get_owner().ready
	zombie_node.name = "Zombies"
	
	add_sibling(zombie_node, true)
	add_child(timer)
	
	timer.one_shot = false
	timer.wait_time = spawn_per_sec
	
	timer.start()
	timer.timeout.connect(timer_ended)

func timer_ended():
	if zombie_node.get_child_count() >= enemy_limit:
		return
	
	var random_index : int = randi() % (spawns.size() - 1)
	var max_tries : int = 5
	var tries : int = 0
	
	while random_index == previous_spawn_index and tries < max_tries:
		random_index = randi() % (spawns.size() - 1)
		tries += 1
	
	var instance = enemy_list.pick_random().instantiate()
	instance.global_transform = spawns[random_index].global_transform
	zombie_node.add_child(instance)
	
	previous_spawn_index = random_index
