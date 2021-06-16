extends Container

signal carrier_selected(Carrier)

const Util = preload("res://util/Util.gd")

export var carrier_path: NodePath
onready var carrier: Carrier
onready var materials = $"/root/MaterialHelper"

func _ready():
	carrier.connect("cargo_changed", self, "display")

	$Cargo/Name.text = carrier.name+" >"
	Util.propagate_signal($Cargo/Name, "pressed", self, "carrier_selected", [carrier])

	for cargo in carrier.cargo:
		var el = $Cargo/CargoSpace.duplicate()
		el.get_node("Payload").texture = null
		$Cargo.add_child(el)
		$Cargo.move_child(el, 0)

	$Cargo.remove_child($Cargo/CargoSpace)
	display()

func display():
	for index in range(len(carrier.cargo)):
		var el = $Cargo.get_child(index)
		var texture = null

		if carrier.cargo[index] != null:
			texture = materials.get_icon(carrier.cargo[index])
			
		el.get_node("Payload").texture = texture
