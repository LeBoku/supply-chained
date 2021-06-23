extends PanelContainer

signal selected(cargo)

func display_requirements(requires:PoolStringArray):
	visible = len(requires) > 0

	for r in requires:
		var icon = $"/root/CargoHelper".get_icon(r)
		var sprite = $Box/Template.duplicate()
		sprite.texture = icon
		sprite.connect("gui_input", self, "on_gui_event_sprite", [r])
		$Box.add_child(sprite)

	$Box/Template.visible = false

func on_gui_event_sprite(event:InputEvent, cargo:String):
	if event is InputEventMouseButton and event.button_index == 1:
		emit_signal("selected", cargo, self)
