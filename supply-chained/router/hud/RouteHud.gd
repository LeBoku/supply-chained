extends HBoxContainer

const play_icon = preload("res://util/icons/play.png")
const pause_icon = preload("res://util/icons/pause.png")

const Util = preload("res://util/Util.gd")
const RouteStepHud = preload("res://router/hud/RouteStepHud.tscn")
var carrier: Carrier

func initialize(carrier: Carrier):
	self.carrier = carrier
	carrier.connect("route_changed", self, "_on_route_changed")

func _on_route_changed():
	Util.remove_children(self, [$State])
	
	if carrier.current_route != null:
		$State.texture = play_icon

		if carrier.current_route.repeats:
			for step in carrier.current_route.steps:
				if len(step.exchanges)>0:
					add_child(RouteStepHud.instance().initialize(step, $"/root/CargoHelper"))

	else:
		$State.texture = pause_icon
