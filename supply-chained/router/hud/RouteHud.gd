extends HBoxContainer

const play_icon = preload("res://util/icons/play.png")
const pause_icon = preload("res://util/icons/pause.png")

const Util = preload("res://util/Util.gd")
const RouteStepHud = preload("res://router/hud/RouteStepHud.tscn")

var route: Route

func set_route(newRoute: Route):
	if route != null:
		route.disconnect("changed", self, "display_route")

	route = newRoute

	if route != null: 
		route.connect("changed", self, "display_route")
		display_route()
		

func display_route():
	Util.remove_children(self, [$State])
	
	if route != null:
		$State.texture = play_icon

		if route.repeats:
			for step in route.steps:
				if len(step.exchanges)>0:
					add_child(RouteStepHud.instance().initialize(step, $"/root/CargoHelper"))
		else:
			add_child(RouteStepHud.instance().initialize(route.steps[0], $"/root/CargoHelper"))
			add_child(RouteStepHud.instance().initialize(route.steps[-1], $"/root/CargoHelper"))
			
	else:
		$State.texture = pause_icon
