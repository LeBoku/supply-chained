extends Node2D

const Route = preload("res://router/Route.tscn")

onready var route_builder = get_node("/root/RouteBuilder")

func _on_carrier_selected(carrier: Carrier):
	var route = yield(route_builder.build_route(carrier, $Map), "completed")
	add_child(route)
	route.start()
