extends Node2D

const Route = preload("res://router/Route.tscn")

onready var route_builder = get_node("/root/RouteBuilder")

func _on_carrier_selected(carrier: Carrier):
	var route = yield(route_builder.build_route(), "completed")
	
	if carrier.current_route != null:
		yield(self.finish_current_route(carrier, route), "completed")
	
	add_child(route)
	route.add_carrier(carrier).start()

func finish_current_route(carrier: Carrier, route: Route):
	var final_station = yield(carrier.current_route.finish(), "completed")
	var start_station = route.steps[0][0]
	var temp_route = route_builder.get_temporary_route(final_station, start_station)
	
	add_child(temp_route)
	yield(temp_route.add_carrier(carrier).start(), "completed")
	temp_route.queue_free()
