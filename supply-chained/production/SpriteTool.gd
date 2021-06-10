tool
extends Sprite

const material_helper = preload("res://material/material_helper.gd")

func _ready():
	texture = material_helper.new().get_icon(get_parent().produces)
