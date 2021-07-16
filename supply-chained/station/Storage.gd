extends Node2D

class_name StationStorage

signal changed

var cargo: PoolStringArray

func initialize(initial_storage: PoolStringArray):
	cargo = initial_storage
	init_empty_spaces(len(initial_storage))
	display_cargo()

func _process(delta):
	for child in get_children():
		child.rotate(delta)
		child.get_node("Sprite").rotate(-delta)

func has(cargo: String):
	return Array(self.cargo).has(cargo)

func remove(to_remove: String):
	cargo[Array(cargo).find(to_remove)] = ""
	display_cargo()

func get_empty_space():
	return Array(cargo).find("")

func add(to_add: String):
	cargo[get_empty_space()] = to_add
	display_cargo()

func display_cargo():
	for i in range(len(cargo)):
		var space = get_child(i)
		var sprite = space.get_node("Sprite") as Sprite
		var c = cargo[i]

		space.visible = c != ""

		if space.visible:
			sprite.texture = $"/root/CargoHelper".get_icon(c)

func init_empty_spaces(count: int):
	var spacing_angle = 360 / count
	var current_angle = 0;

	for cargo in range(count):
		var space = $Template.duplicate()
		space.rotate(deg2rad(current_angle))
		add_child(space)
		move_child(space, 0)
		
		current_angle += spacing_angle

	$Template.visible = false
