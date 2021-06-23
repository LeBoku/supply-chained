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
			for step in carrier.current_route.steps:
				if len(step.exchanges) > 0:
					var label = Label.new()
					label.text = step.station.name
					add_child(label)
		else:
			$State.text = "Rerouting"

	else:
		$State.text = "Idle"
