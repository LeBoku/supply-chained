extends Node2D

signal resources_produced(target, resource)

export(Array, Resource) var recipies = []
export(Array, NodePath) var produces_to = []
export(Array, NodePath) var requires_from = []

const Util = preload("res://util/Util.gd")

func _ready():
	while is_instance_valid(self):
		yield(start_production(), 'completed')

func start_production():
	var recipie = yield(get_recipie(), 'completed')
	yield(get_tree().create_timer(recipie.time),  "timeout")
	yield(finalize_production(recipie), 'completed')

func finalize_production(recipie: Recipie):
	yield(wait_for_space(), 'completed')
		
	for index in range(len(recipie.produces)):
		var resource = recipie.produces[index]
		var target = get_node(produces_to[index]) as Station
		target.dropoff(0, resource)

func get_recipie():
	yield(get_tree().create_timer(0),  "timeout")
	return recipies[0] as Recipie
	
func wait_for_space():
	yield(get_tree().create_timer(0),  "timeout")
	var has_space = false

	while not has_space:
		has_space = true
		var wait_for = []

		for s in produces_to:
			var station := get_node(s) as Station
			if not station.has_space(0):
				wait_for.append([station, 'contents_changed'])
				has_space = false

		if not has_space:
			yield(Util.yield_await_first(wait_for), 'completed')
