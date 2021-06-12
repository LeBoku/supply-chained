extends Node

var icons = {
	"placeholder": preload("res://material/icons/placeholder.png"),
	"coal": preload("res://material/icons/coal.png"),
	"iron-ore": preload("res://material/icons/iron-ore.png"),
	"iron": preload("res://material/icons/iron.png"),
	"wheat": preload("res://material/icons/wheat.png"),
	"wood": preload("res://material/icons/wood.png"),
	"labor": preload("res://material/icons/labor.png"),
}

func get_icon(name:String):
	return icons[name] if icons.has(name) else icons["placeholder"]
