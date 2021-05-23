extends Node

signal route_finalized 

const Route = preload("res://router/Route.tscn");

var active = false
var steps = []

func build_route(carrier):
	active = true
	steps = []
	enable_stations(true)

	yield(self, "route_finalized")

	return Route.instance().init(steps, carrier)

func add_step(station: Station, production: Production):
	enable_stations(false)

	if len(steps)>1 and station == steps[0][0]:
		emit_signal("route_finalized")
	else:
		steps.append([station, [production]])
		enable_stations(true, station.get_connected_stations())

func enable_stations(enabled: bool, stations=get_tree().get_nodes_in_group('Station')):
	for s in stations:
		var station := s as Station
		station.set_enabled(enabled)

