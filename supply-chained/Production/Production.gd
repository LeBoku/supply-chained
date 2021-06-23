extends Node2D

class_name Production
export var requires: PoolStringArray = ["labor"]
export var produces: String

func _ready():
	add_to_group("Production")
	set_enabled(false)
	
	$Sprite.texture = $"/root/CargoHelper".get_icon(produces)
	
	$Connector.visible = true
	$Connector.add_point(Vector2())
	$Connector.add_point(-position)
	
	$Requirements.initialize_cargo(requires)
		
func _on_Button_pressed():
#	$"/root/RouteBuilder".add_step(get_parent(), self)
	pass

func set_enabled(enabled):
	$Sprite/Highlighter.set_active(enabled)
	$Button.disabled = not enabled
	
func _on_cargo_selected(list: CargoList, cargo:String, pickup:bool = false):
	$"/root/RouteBuilder".add_step(get_parent(), [list, cargo, pickup])
