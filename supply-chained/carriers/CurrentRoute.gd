extends HBoxContainer

const Util = preload("res://util/Util.gd")

var carrier: Carrier

func initialize(carrier: Carrier):
	self.carrier = carrier
	carrier.connect("route_changed", self, "_on_route_changed")

func _on_route_changed():
	Util.remove_children(self, [$State])
	
	if carrier.current_route != null:
		if carrier.current_route.repeats:
			$State.text = "On route"
			for stop in carrier.current_route.steps:
				if len(stop[1]) > 0:
					var label = Label.new()
					label.text = stop[0].name
					add_child(label)
		else:
			$State.text = "Rerouting"

	else:
		$State.text = "Idle"
