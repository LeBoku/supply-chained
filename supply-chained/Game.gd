extends Node2D

const Route = preload("res://router/Route.tscn");

func _on_train_pressed():
#	enable_stations(true)
#	var station = null
#	var steps = []
#
#	while len(steps) == 0 or station != steps[0]:
#		if station != null:
#			steps.append(station)
#			enable_stations(true, station.get_connected_stations())
#
#		station = yield($Map, "station_selected") as Station
#		enable_stations(false)
#
#	$Train1.visible = true
#	var route = Route.instance().init(steps, $Train1)
#	add_child(route)
#	route.start()

func enable_stations(enabled:bool, stations=get_tree().get_nodes_in_group('Station')):
	for s in stations:
		var station := s as Station
		station.set_enabled(enabled)
