extends Node2D

class_name Carrier

signal cargo_changed
signal route_changed
signal temporary_route_changed

export var cargo: Array = []

var current_route = null
var temp_route = null

func _ready():
	emit_signal("cargo_changed")
	add_to_group("carrier")

func get_empty_cargo_spot():
	return cargo.find(null)

func get_remaining_capacity():
	return len(cargo) - get_empty_cargo_spot()

func add_cargo(content):
	yield(get_tree().create_timer(0), "timeout")
	var index = get_empty_cargo_spot()
	
	if index != -1:
		cargo[index] = content
		yield(get_tree().create_timer(1), "timeout")
		update_cargo()

func has(content):
	return cargo.has(content)

func remove_cargo(content):
	cargo[cargo.find(content)] = null
	yield(get_tree().create_timer(1), "timeout")
	update_cargo()

func update_cargo():
	emit_signal("cargo_changed")
	
func update_route(route, clear_temp_route = true):
	current_route = route
	emit_signal("route_changed")
	
	if clear_temp_route:
		update_temp_route(null)

func update_temp_route(route):
	temp_route = route
	emit_signal("temporary_route_changed")
	
