extends Node2D

signal resources_produced(target, resource)

export(Array, Resource) var recipies = []
export(Array, NodePath) var produces_to = []
export(Array, NodePath) var requires_from = []

const Util = preload("res://util/Util.gd")

onready var _produces_to = convert_node_paths(produces_to)
onready var _requires_from = convert_node_paths(requires_from)

func _ready():
	while is_instance_valid(self):
		yield(start_production(), 'completed')

func start_production():
	var recipie = yield(get_recipie(), 'completed')
	yield(produce(recipie), 'completed')
	yield(finalize_production(recipie), 'completed')

func finalize_production(recipie: Recipie):
	yield(wait_for_space(), 'completed')
		
	for index in range(len(recipie.produces)):
		var resource = recipie.produces[index]
		var target = _produces_to[index] as Station
		target.dropoff(0, resource)

func get_recipie():
	yield(get_tree().create_timer(0),  "timeout")
	
	while is_instance_valid(self):
		for r in recipies:
			if has_requirements(r):
				return recipies[0] as Recipie

		var awaitables = Util.get_as_awaitables(_requires_from, 'contents_changed')
		yield(Util.yield_await_first(awaitables), 'completed')

func produce(recipie: Recipie):
	for index in range(len(recipie.requires)):
		_requires_from[index].dropoff(0, null)

	yield(get_tree().create_timer(recipie.time),  "timeout")

func has_requirements(recipie: Recipie):
	var has = true
	for index in range(len(recipie.requires)):
		has = has and _requires_from[index].has_content(0, recipie.requires[index])

	return has

func wait_for_space():
	yield(get_tree().create_timer(0),  "timeout")
	var has_space = false

	while not has_space:
		has_space = true
		var wait_for = []

		for s in _produces_to:
			var station := s as Station
			if not station.has_content(0, null):
				wait_for.append([station, 'contents_changed'])
				has_space = false

		if not has_space:
			yield(Util.yield_await_all(wait_for), 'completed')
			
func convert_node_paths(paths:Array):
	var nodes = []
	for path in paths:
		nodes.append(get_node((path)))
	return nodes
