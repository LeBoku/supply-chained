extends Node

const Route = preload("res://router/Route.tscn");

var active = false
var steps = []
var pickups = {}
var current_pickup = get_empty_pickup()

func build_route(carrier, map):
	enable_stations(true)
	var station = null
	active = true
	steps = []
	pickups = {}

	while len(steps) == 0 or station != steps[0]:
		if station != null:
			steps.append(station)
			station.set_focused(true)
			current_pickup = get_empty_pickup()
			enable_stations(true, station.get_connected_stations())

		station = yield(map, "station_selected") as Station
		
		enable_stations(false)
	
	carrier.visible = true
	active = false
	return Route.instance().init(steps, carrier, pickups)

func add_pickup_point(index: int):
	current_pickup["point"] = index
	add_pickup_if_complete()
	
func add_cargo_index(index: int):
	current_pickup["cargo"] = index
	add_pickup_if_complete()
	
func enable_stations(enabled: bool, stations=get_tree().get_nodes_in_group('Station')):
	for s in stations:
		var station := s as Station
		station.set_enabled(enabled)
		
		if not enabled:
			station.set_focused(false)
		
func add_pickup_if_complete():
	if current_pickup["point"] != null and current_pickup["cargo"]!=null:
		var index = len(steps)-1
		
		if not pickups.has(index):
			pickups[index] = []
			
		var current_pickups = pickups[index]
		current_pickups.append(current_pickup)
		
		current_pickup = get_empty_pickup()
		
func get_empty_pickup():
	return {"point": null, "cargo":null}
