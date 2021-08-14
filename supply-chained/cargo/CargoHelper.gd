extends Node

signal cargo_created(Cargo)
var existing_cargo = []

const Cargo = preload("res://cargo/cargo/Cargo.tscn")
var icons = {
	"placeholder": preload("res://cargo/icons/placeholder.png"),
	"coal": preload("res://cargo/icons/coal.png"),
	"iron-ore": preload("res://cargo/icons/iron-ore.png"),
	"iron": preload("res://cargo/icons/iron.png"),
	"wheat": preload("res://cargo/icons/wheat.png"),
	"bread": preload("res://cargo/icons/bread.png"),
	"wood": preload("res://cargo/icons/wood.png"),
	"labor": preload("res://cargo/icons/labor.png"),
	"labor-exhausted": preload("res://cargo/icons/labor-exhausted.png"),
}

func get_icon(type: String):
	return icons[type] if icons.has(type) else icons["placeholder"]

func create_cargo(type: String):
	if icons.has(type):
		return _create_cargo(type)
	else:
		return null

func _create_cargo(type: String):
	var cargo = Cargo.instance().init(type, get_icon(type))
	existing_cargo.append(cargo)

	emit_signal("cargo_created", cargo)
	return cargo
