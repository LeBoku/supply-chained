extends CargoStorage

class_name StationStorage

func initialize(initial_storage: PoolStringArray):
	.initialize(initial_storage)
	init_empty_spaces(len(stored_cargo))
	display_cargo()

func storage_updated():
	.storage_updated()
	display_cargo()

func display_cargo():
	print()
	print(get_child_count())
	for i in range(len(stored_cargo)):
		print(i)
		var space = get_child(i)
		var spot = space.get_node("CargoSpot") as Position2D
		var c = stored_cargo[i] as Cargo
		space.visible = c != null

		if space.visible:
			c.global_position = spot.global_position

func init_empty_spaces(count: int):
	var spacing_angle = 360.0 / count
	var current_angle = 0;

	for _i in range(count):
		var space = $Template.duplicate()
		space.rotate(deg2rad(current_angle))
		add_child(space)
		
		current_angle += spacing_angle
	
	move_child($Template, get_child_count())
	$Template.queue_free()
