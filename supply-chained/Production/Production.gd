extends Node2D

class_name Production
export var requires: PoolStringArray = ["labor"]
export var produces: PoolStringArray = []

func _ready():
	add_to_group("Production")
	set_enabled(false)
	
	$Connector.visible = true
	$Connector.add_point(Vector2())
	$Connector.add_point(-position)
	
	$Requirements.initialize_cargo(requires)
	$Produces.initialize_cargo(produces)

func set_enabled(enabled):
	pass
#	$Highlighter.set_active(enabled)
#	$Button.disabled = not enabled
	
func _on_cargo_selected(list: CargoList, cargo:String, pickup:bool = false):
	$"/root/RouteBuilder".add_step(get_parent(), CargoExchange.new().initialize(cargo, pickup))
