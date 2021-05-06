extends Node2D

class_name Carrier

signal cargo_changed

export var cargo_capacity = 3
export var cargo = []

func _ready():
	cargo = []
	cargo.resize(cargo_capacity)
	emit_signal("cargo_changed")

func dropoff(position: int):
	var dropoff = cargo[position]
	yield(get_tree().create_timer(2), "timeout")
	return dropoff

func set_cargo(position: int, content):
	cargo[position] = content
	emit_signal("cargo_changed")
