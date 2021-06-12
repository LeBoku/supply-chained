extends Node

signal route_finalized 

const Route = preload("res://router/Route.tscn");

var active = false
var steps = []

func build_route(carrier):
	active = true
	steps = []
	enable_stops(true)

	yield(self, "route_finalized")

	return Route.instance().init(steps, carrier)

func add_step(station: Station, production: Production):
	enable_stops(false)
	
	if len(steps) > 0 and station == steps[-1][0]:
		steps[-1][1].append(production)
		enable_stops(true)
		
	elif len(steps) > 1 and station == steps[0][0]:
		emit_signal("route_finalized")
		
	else:
		steps.append([station, [production]])
		enable_stops(true)

func enable_stops(enabled: bool):
	for p in get_tree().get_nodes_in_group('Production'):
		var production := p as Production
		production.set_enabled(enabled)

