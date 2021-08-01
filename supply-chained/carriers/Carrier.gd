extends CargoStorage

class_name Carrier

signal route_changed
signal temporary_route_changed

const Util = preload("res://util/Util.gd")

var current_route = null
var temp_route = null

func _ready():
	emit_signal("changed")
	add_to_group("carrier")

func update_route(route, clear_temp_route = true):
	current_route = route
	emit_signal("route_changed")
	
	if clear_temp_route:
		update_temp_route(null)

func update_temp_route(route):
	temp_route = route
	emit_signal("temporary_route_changed")
	
