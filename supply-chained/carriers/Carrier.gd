extends Node2D

class_name Carrier

export var cargo_capacity = 3
export var hud_node: NodePath

var cargo = []

func _ready():
	cargo = []
	cargo.resize(cargo_capacity)
	display_cargo()

func set_cargo(position: int, content):
	cargo[position] = content
	display_cargo()
	
func display_cargo():
	var hud = get_node(hud_node) as Button
	var text = name
	
	for c in cargo:
		if c == null:
			c = "  "
			
		text += " [" + c + "]"

	hud.text = text
