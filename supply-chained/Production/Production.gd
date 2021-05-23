extends Node2D

class_name Production
export var produces: String

func _ready():
	add_to_group("production")

func _on_Button_pressed():
	$"/root/RouteBuilder".add_step(get_parent(), self)
