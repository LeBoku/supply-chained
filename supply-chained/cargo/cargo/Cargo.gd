extends Node2D

class_name Cargo

var type: String
var texture: Texture

func _ready():
	add_to_group("Cargo")
	$Icon.texture = texture

func init(type:String, texture:Texture):
	self.type = type
	self.texture = texture
	
	return self
	
func is_type(type: String):
	return self.type == type

