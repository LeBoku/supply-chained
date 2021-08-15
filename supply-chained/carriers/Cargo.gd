extends HBoxContainer

const Util = preload("res://util/Util.gd")

var carrier: Carrier
onready var cargo_helper = $"/root/CargoHelper"

func initialize(carrier: Carrier):
	self.carrier = carrier
	$Name.text = carrier.name

	for index in range(len(carrier.stored_cargo)):
		var el = $CargoSpace.duplicate() as Panel
		el.connect("gui_input", self, "_on_CargoSpace_click", [index, el])
		el.get_node("Payload").texture = null
		add_child(el)

	remove_child($CargoSpace)
	move_child($Name, get_child_count())
	
	carrier.connect("changed", self, "display")
	display()

func display():
	for index in range(len(carrier.stored_cargo)):
		var el = get_child(index)
		var cargo = carrier.stored_cargo[index]
		var texture = cargo.texture if cargo != null else null
			
		el.get_node("Payload").texture = texture

func _on_CargoSpace_click(event: InputEvent, index: int, element: Panel):
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		var lock = element.get_node("Lock")
		lock.visible = not lock.visible
		carrier.set_locked(index, lock.visible)
