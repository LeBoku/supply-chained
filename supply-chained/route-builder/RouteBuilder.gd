extends Node

const Route = preload("res://router/Route.tscn");

var steps = [];
var pickups = [];

func build_route(carrier, map):
	enable_stations(true)
	var station = null
	steps = []
	pickups = []

	while len(steps) == 0 or station != steps[0]:
		if station != null:
			steps.append(station)
			enable_stations(true, station.get_connected_stations())

		station = yield(map, "station_selected") as Station
		
		enable_stations(false)
		station.show_pickup_panel()
	
	carrier.visible = true
	return Route.instance().init(steps, carrier)

func enable_stations(enabled:bool, stations=get_tree().get_nodes_in_group('Station')):
	for s in stations:
		var station := s as Station
		station.set_enabled(enabled)
		
