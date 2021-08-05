extends Node2D

class_name CargoStorage

signal changed

export var cargo: PoolStringArray
var locked_indexes =  []

func initialize(initial_storage: PoolStringArray):
	cargo = initial_storage
	return self

func add(to_add: String):
	print(get_empty_space())
	cargo[get_empty_space()] = to_add
	storage_updated()
	
func remove(to_remove: String):
	cargo[find_unlocked(to_remove)] = ""
	storage_updated()

func has(cargo: String):
	return get_unlocked().has(cargo)
	
func has_empty_space():
	return get_empty_space() != -1

func get_empty_space():
	return find_unlocked("")

func set_locked(index: int, locked: bool):
	if locked:
		locked_indexes.append(index)
	else:
		locked_indexes.erase(index)

func get_unlocked():
	var unlocked = Array(cargo)
	
	for index in locked_indexes:
		unlocked.remove(index)
	
	return unlocked
	
func find_unlocked(cargo_to_find: String):
	var found = null
	var search_from = 0

	while found == null:
		found = Array(cargo).find(cargo_to_find, search_from)
		print(found)
		print(locked_indexes)
		if locked_indexes.has(found):
			search_from = found + 1
			found = null
		
		if search_from > len(cargo):
			found = -1
	
	return found

func storage_updated():
	emit_signal("changed")

