extends HBoxContainer

signal carrier_selected(Carrier)

const Util = preload("res://util/Util.gd")

export var carrier_path: NodePath
onready var carrier = get_node(carrier_path) as Carrier

func _ready():
	display()
	carrier.connect("cargo_changed", self, "display")

func display():
	Util.remove_children(self)

	for index in range(len(carrier.cargo)):
		var button = Button.new()
		button.text = " "

		if carrier.cargo[index] != null:
			button.text = carrier.cargo[index]

#		button.connect("pressed", get_node('/root/RouteBuilder'), "add_cargo_index", [index])
		add_child(button)

	var button = Button.new()
	button.text = carrier.name+">"
	
	Util.propagate_signal(button, "pressed", self, "carrier_selected", [carrier])

	add_child(button)
