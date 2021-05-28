extends Node2D

class_name Production
export var produces: String

func _ready():
	add_to_group("production")
	$Sprite.texture = $"/root/MaterialHelper".get_icon(produces)
	var parent_position = get_parent().global_position
	
	$Connector.visible = true
	$Connector.add_point(Vector2())
	$Connector.add_point(-position)
		
func _on_Button_pressed():
	$"/root/RouteBuilder".add_step(get_parent(), self)
