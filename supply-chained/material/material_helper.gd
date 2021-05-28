extends Node

var icons = {
	"placeholder": preload("res://material/icons/placeholder.png"),
	"coal": preload("res://material/icons/coal.png"),
	"iron": preload("res://material/icons/iron.png"),
	"wheat": preload("res://material/icons/wheat.png"),
	"wood": preload("res://material/icons/wood.png"),
}

func get_icon(name:String):
	return icons[name] if icons.has(name) else icons["placeholder"]