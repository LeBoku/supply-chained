extends Node

const Route = preload("res://router/Route.tscn");

var steps = [];
var pickups = {};

func build_route(carrier, map):
	enable_stations(true)
	var station = null
	steps = []
	pickups = {}

	while len(steps) == 0 or station != steps[0]:
		if station != null:
			steps.append(station)
			station.show_pickup_panel()
			enable_stations(true, station.get_connected_stations())

		station = yield(map, "station_selected") as Station
		
		enable_stations(false)
	
	carrier.visible = true
	return Route.instance().init(steps, carrier, pickups)

func add_pickup(id: String, dropoff: bool):
	var index = len(steps)-1
	
	if not pickups.has(index):
		pickups[index] = []
		
	var current_pickups = pickups[index]
	current_pickups.append({"id": id, "dropoff": dropoff})

func enable_stations(enabled:bool, stations=get_tree().get_nodes_in_group('Station')):
	for s in stations:
		var station := s as Station
		station.set_enabled(enabled)
		
