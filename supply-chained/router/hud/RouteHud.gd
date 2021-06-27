extends HBoxContainer

const play_icon = preload("res://util/icons/play.png")
const pause_icon = preload("res://util/icons/pause.png")
const Util = preload("res://util/Util.gd")

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
				if len(step.exchanges) > 0:
					var label = Label.new()
					label.text = step.station.name
					add_child(label)
								
					for exchange in step.exchanges:
						if len(step.exchanges) > 0:
							var exchange_label = Label.new()
							exchange_label.text = ('+' if exchange[2] else '-')+ exchange[1]
							
							add_child(exchange_label)

	else:
		$State.texture = pause_icon
