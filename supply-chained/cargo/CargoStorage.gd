extends Node2D

class_name CargoStorage

signal changed

export var cargo: PoolStringArray

func initialize(initial_storage: PoolStringArray):
	cargo = initial_storage
	return self

func add(to_add: String):
	cargo[get_empty_space()] = to_add
	storage_updated()
	
func remove(to_remove: String):
	cargo[Array(cargo).find(to_remove)] = ""
	storage_updated()

func exchange(cargo: String, other_storage: CargoStorage):
	pass

func has(cargo: String):
	return Array(self.cargo).has(cargo)
	
func has_empty_space():
	return get_empty_space() != -1

func get_empty_space():
	return Array(cargo).find("")

func storage_updated():
	emit_signal("changed")
