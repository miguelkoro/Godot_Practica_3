extends Node2D
var pos_array: Array[Vector2]
@export var target: Node2D = null
@export var zombie: PackedScene = null
@onready var tank: CharacterBody2D = $"../tank"


func _ready() -> void:
	for child in get_children():
		if(child is Marker2D):
			pos_array.push_back(child.global_position) # añade la posicion de cada hijo (marcador) al array


func _on_timer_timeout() -> void:
	##Aqui crearemos los objetos de forma random sobre las posiciones random
	#if pos_array.size() == 0 or scenesToSpawn.size() == 0:
	#	return
	var pos: Vector2 = pos_array.pick_random()
	#var scene: PackedScene = scenesToSpawn.pick_random()
	#var new_scene: Node2D = scene.instantiate()
	#new_scene.when_my_box_is_appear.connect(_on_rigid_body_2d_when_my_box_is_appear)
	#new_scene.global_position=pos
	var zombie_scene: Node2D = zombie.instantiate()
	zombie_scene.global_position= pos
	zombie_scene.get_child(0).set_target(tank)
	add_child(zombie_scene)
	
