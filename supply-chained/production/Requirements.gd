extends PanelContainer

func display_requirements(requires:PoolStringArray):
	visible = len(requires) > 0

	for r in requires:
		var icon = $"/root/MaterialHelper".get_icon(r)
		var sprite = $Box/Template.duplicate()
		sprite.texture = icon
		$Box.add_child(sprite)

	$Box/Template.visible=false
