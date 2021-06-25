extends Tween

export var strength = 0.5

func _ready():
	var x = get_parent().scale.x
	var y = get_parent().scale.y

	interpolate_property(get_parent(), "scale:x", 1, x + x * strength, .3)
	interpolate_property(get_parent(), "scale:y", 1, y + y * strength, .3)
