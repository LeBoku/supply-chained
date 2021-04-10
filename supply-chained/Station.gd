extends Sprite
class_name Station

signal selected(Station)

func _ready():
	$Tween.interpolate_property(self, "scale:x", 0.2, 0.3, .3)
	$Tween.interpolate_property(self, "scale:y", 0.2, 0.3, .3)

func set_enabled(enabled):
	$Button.disabled = !enabled
	$Tween.set_active(enabled)

func _on_pressed():
	emit_signal("selected", self)
