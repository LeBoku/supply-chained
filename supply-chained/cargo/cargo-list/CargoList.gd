extends PanelContainer
class_name CargoList

signal selected(cargo)

func initialize_cargo(requires:PoolStringArray):
	visible = len(requires) > 0
	var sorted = Array(requires)
	sorted.sort()
	
	for r in sorted:
		var icon = $"/root/CargoHelper".get_icon(r)
		var sprite = $Box/Template.duplicate()
		sprite.texture = icon
		sprite.connect("gui_input", self, "_on_sprite_gui_event", [r])
		$Box.add_child(sprite)

	$Box/Template.visible = false
	$Box.move_child($Box/Template, $Box.get_child_count())

func _on_sprite_gui_event(event:InputEvent, cargo:String):
	if event is InputEventMouseButton and event.button_index == 1 and event.is_pressed():
		emit_signal("selected", cargo)
