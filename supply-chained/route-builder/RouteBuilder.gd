extends Node

signal route_finalized 

const Route = preload("res://router/Route.tscn");
const Step = preload("res://route-builder/RouteStep.gd")
const Sorter = preload("res://util/Sorter.gd");

var active = false
var route: Route = null 

func get_temporary_route(from_station: Station, to_station: Station):
	var stations = [from_station] + get_stations_between(from_station, to_station) + [to_station]
	return Route.instance().init(get_steps(stations), false)

func build_route():
	active = true
	route = Route.instance()
	route.editing = true
	
	enable_stops(true)

	return route

func add_step(station: Station, cargo_exchange: CargoExchange):
	if len(route.steps) == 0 or station != route.steps[-1].station:
		var stations = [station]
		if len(route.steps) > 0:
			stations = get_stations_between(route.steps[-1].station, station) + stations 
		
		var steps = get_steps(stations)
		route.add_steps(steps)

	if len(route.steps) > 1 and station == route.steps[0].station and cargo_exchange.is_same(route.steps[0].exchanges[0]):
		finish_route()
	else:
		route.add_exchange(-1, cargo_exchange)

func enable_stops(enabled: bool):
	for p in get_tree().get_nodes_in_group('Production'):
		var production := p as Production
		production.set_enabled(enabled)

func finish_route():
	enable_stops(false)
	route.editing = false
	route = null
	active = false

	emit_signal("route_finalized")

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
