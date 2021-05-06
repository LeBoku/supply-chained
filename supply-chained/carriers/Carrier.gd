extends Node2D

class_name Carrier

signal cargo_changed

export var cargo = []

func _ready():
	emit_signal("cargo_changed")

func dropoff(position: int):
	var dropoff = cargo[position]
	yield(get_tree().create_timer(2), "timeout")
	return dropoff

func set_cargo(position: int, content):
	cargo[position] = content
	emit_signal("cargo_changed")
