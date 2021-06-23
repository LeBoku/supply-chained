extends Node

signal route_finalized 

const Route = preload("res://router/Route.tscn");
const Step = preload("res://route-builder/RouteStep.gd")
const Sorter = preload("res://util/Sorter.gd");

var active = false
var steps = []

func get_temporary_route(from_station: Station, to_station: Station):
	var stations = [from_station] + get_stations_between(from_station, to_station) + [to_station]
	return Route.instance().init(get_steps(stations), false)

func build_route():
	active = true
	steps = []
	enable_stops(true)

	yield(self, "route_finalized")
	return Route.instance().init(steps)

func add_step(station: Station, cargo_exchange: Array):
	if len(steps) == 0 or station != steps[-1].station:
		var stations = [station] 
		if len(steps) > 0:
			stations = get_stations_between(steps[-1].station, station) + stations 
		
		steps.append_array(get_steps(stations))

	steps[-1].add_exchange(cargo_exchange)

	if len(steps) > 1 and station == steps[0].station:
		emit_signal("route_finalized")
		enable_stops(false)

func enable_stops(enabled: bool):
	for p in get_tree().get_nodes_in_group('Production'):
		var production := p as Production
		production.set_enabled(enabled)

func get_stations_between(stationA: Station, stationB: Station, intermediate_stations:Array = []):
	var connections = stationA.get_connected_stations()
	
	if not connections.has(stationB):
		var possibilities = []
		
		for station in connections:
			if not intermediate_stations.has(station):
				possibilities.append(get_stations_between(station,stationB, intermediate_stations + [station]))
				
		possibilities.sort_custom(Sorter, "sort_by_array_length")
		
		if len(possibilities) > 0:
			intermediate_stations += possibilities[0]
	
	return intermediate_stations
	
func get_steps(stations:Array):
	var steps = []

	for station in stations:
		steps.append(Step.new().initialize(station))

	return steps
