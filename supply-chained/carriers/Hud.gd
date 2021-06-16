extends Container

signal carrier_selected(Carrier)

const Util = preload("res://util/Util.gd")

export var carrier_path: NodePath
onready var carrier: Carrier
onready var materials = $"/root/MaterialHelper"

func _ready():
	$Cargo.initialize(carrier)
	$CurrentRoute.initialize(carrier)

func _on_Name_pressed():
	emit_signal("carrier_selected", carrier)
