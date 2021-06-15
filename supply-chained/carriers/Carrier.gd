extends Node2D

class_name Carrier

signal cargo_changed

export var cargo: Array = []

var current_route = null 

func _ready():
	emit_signal("cargo_changed")

func get_empty_cargo_spot():
	return cargo.find(null)

func get_remaining_capacity():
	return len(cargo) - get_empty_cargo_spot()

func add_cargo(content):
	var index = get_empty_cargo_spot()
	var timeout = 0
	
	if index != -1:
		cargo[index] = content
		timeout = 1
		update_cargo()

	yield(get_tree().create_timer(timeout), "timeout")
		
func update_cargo():
	emit_signal("cargo_changed")
