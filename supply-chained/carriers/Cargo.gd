extends HBoxContainer

const Util = preload("res://util/Util.gd")

var carrier: Carrier
onready var cargo_helper = $"/root/CargoHelper"

func initialize(carrier: Carrier):
	self.carrier = carrier
	$Name.text = carrier.name+" >"

	for cargo in carrier.cargo:
		var el = $CargoSpace.duplicate()
		el.get_node("Payload").texture = null
		add_child(el)
		move_child(el, 0)

	remove_child($CargoSpace)
	
	carrier.connect("changed", self, "display")
	display()

func display():
	for index in range(len(carrier.cargo)):
		var el = get_child(index)
		var texture = null

		if carrier.cargo[index] != "":
			texture = cargo_helper.get_icon(carrier.cargo[index])
			
		el.get_node("Payload").texture = texture
