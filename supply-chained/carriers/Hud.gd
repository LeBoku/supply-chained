extends HBoxContainer

signal carrier_selected(Carrier)

const Util = preload("res://util/Util.gd")

export var carrier_path: NodePath
onready var carrier = get_node(carrier_path) as Carrier
onready var materials = $"/root/MaterialHelper"

func _ready():
	carrier.connect("cargo_changed", self, "display")

	$Name.text = carrier.name+" >"
	Util.propagate_signal($Name, "pressed", self, "carrier_selected", [carrier])

	for cargo in carrier.cargo:
		var el = $CargoSpace.duplicate()
		el.get_node("Payload").texture = null
		add_child(el)
		move_child(el, 0)

	remove_child($CargoSpace)
	display()

func display():
	for index in range(len(carrier.cargo)):
		var el = get_child(index)
		var texture = null

		if carrier.cargo[index] != null:
			texture = materials.get_icon(carrier.cargo[index])
			
		el.get_node("Payload").texture = texture
