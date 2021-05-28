extends Node2D

class_name Production
export var produces: String

func _ready():
	add_to_group("production")
	var parent_position = get_parent().global_position
	
	print(global_position.distance_to(parent_position))
	if global_position.distance_to(parent_position) > 10:
		$Connector.visible = true
		$Connector.add_point(Vector2())
		$Connector.add_point(-position)
		
func _on_Button_pressed():
	$"/root/RouteBuilder".add_step(get_parent(), self)
