extends Node

var icons = {
	"placeholder": preload("res://cargo/icons/placeholder.png"),
	"coal": preload("res://cargo/icons/coal.png"),
	"iron-ore": preload("res://cargo/icons/iron-ore.png"),
	"iron": preload("res://cargo/icons/iron.png"),
	"wheat": preload("res://cargo/icons/wheat.png"),
	"bread": preload("res://cargo/icons/bread.png"),
	"wood": preload("res://cargo/icons/wood.png"),
	"labor": preload("res://cargo/icons/labor.png"),
	"labor-exhausted": preload("res://cargo/icons/labor-exhausted.png"),
}

func get_icon(name:String):
	return icons[name] if icons.has(name) else icons["placeholder"]
