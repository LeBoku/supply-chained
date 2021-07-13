extends Container

signal carrier_selected(Carrier)

const Util = preload("res://util/Util.gd")

export var carrier_path: NodePath
onready var carrier: Carrier

func _ready():
	$Cargo.initialize(carrier)
	
	carrier.connect("temporary_route_changed", self, "_on_temporary_route_changed")
	carrier.connect("route_changed", self, "_on_route_changed")

func _on_Name_pressed():
	emit_signal("carrier_selected", carrier)

func _on_route_changed():
	$CurrentRoute.visible = carrier.current_route != null
	$CurrentRoute.set_route(carrier.current_route)

func _on_temporary_route_changed():
	$TempRoute.visible = carrier.temp_route != null
	$TempRoute.set_route(carrier.temp_route)
