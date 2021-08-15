extends Carrier
var wagons_ready = false

func _ready():
	._ready()
	initialize_wagons()

func initialize_wagons():
	var first_wagon = $Wagon
	for index in range(1, len(stored_cargo)):
		var wagon = first_wagon.duplicate()
		wagon.position.x = -2.5 + (index * -5.5)
		add_child(wagon)
	wagons_ready = true

func _on_stored_cargo_changed():
	if !wagons_ready: return
	
	for index in len(stored_cargo):
		var cargo = stored_cargo[index] as Cargo
		var wagon = get_child(index)
		
		if cargo != null:
			if wagon.get_child_count() == 0:
				wagon.add_child(_get_remote_transform())

			var spot = wagon.get_child(0) as RemoteTransform2D
			spot.remote_path = cargo.get_path()
		else:
			Util.remove_children(wagon)
			
func _get_remote_transform():
	var transform = RemoteTransform2D.new()
	transform.update_scale = false
	transform.update_rotation = false

	return transform
