extends Node2D

const Route = preload("res://router/Route.tscn")

onready var route_builder = get_node("/root/RouteBuilder")

func _on_train_pressed():
	var route = yield(route_builder.build_route($Train1, $Map), "completed")
	add_child(route)
	route.start()

func enable_stations(enabled:bool, stations=get_tree().get_nodes_in_group('Station')):
	for s in stations:
		var station := s as Station
		station.set_enabled(enabled)
