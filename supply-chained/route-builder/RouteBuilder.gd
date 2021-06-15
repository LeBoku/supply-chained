extends Node

signal route_finalized 

const Route = preload("res://router/Route.tscn");
const Sorter = preload("res://util/Sorter.gd");

var active = false
var steps = []

func get_temporary_route(from_station: Station, to_station: Station):
	var stations = [from_station] + get_steps_between(from_station, to_station) + [to_station]
	var steps = []
	
	for station in stations:
		steps.append([station, []])
		
	return Route.instance().init(steps, false)

func build_route():
	active = true
	steps = []
	enable_stops(true)

	yield(self, "route_finalized")
	return Route.instance().init(steps)

func add_step(station: Station, production: Production):
	enable_stops(false)

	if len(steps) > 0 and station == steps[-1][0]:
		steps[-1][1].append(production)
		enable_stops(true)
	else:
		if len(steps) > 0:
			for intermediate_station in get_steps_between(steps[-1][0], station): 
				steps.append([intermediate_station, []])

		if len(steps) > 1 and station == steps[0][0]:
			emit_signal("route_finalized")
			
		else:
			steps.append([station, [production]])
			enable_stops(true) 

func enable_stops(enabled: bool):
	for p in get_tree().get_nodes_in_group('Production'):
		var production := p as Production
		production.set_enabled(enabled)

func get_steps_between(stationA: Station, stationB: Station, intermediate_stations:Array = []):
	var connections = stationA.get_connected_stations()
	
	if not connections.has(stationB):
		var possibilities = []
		
		for station in connections:
			if not intermediate_stations.has(station):
				possibilities.append(get_steps_between(station,stationB, intermediate_stations + [station]))
				
		possibilities.sort_custom(Sorter, "sort_by_array_length")
		
		if len(possibilities) > 0:
			intermediate_stations += possibilities[0]
	
	return intermediate_stations
