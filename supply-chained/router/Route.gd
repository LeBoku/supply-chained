extends Node2D

const RouteSegment = preload("res://router/RouteSegment.tscn")

var steps: Array
var carrier: Carrier

func init(steps:Array, carrier: Carrier):
	self.steps = steps
	self.carrier = carrier
	return self

func start():
	carrier.visible = true
	var step_index = 0
	
	while is_instance_valid(self):
		var step =steps[step_index]
		yield(handle_pickups(step[0], step[1]), 'completed')

		var next_index = step_index + 1
		if next_index > len(steps)-1:
			next_index=0
		
		yield(travel(steps[step_index][0], steps[next_index][0]), 'completed')
		step_index = next_index
		
func travel(from: Station, to: Station):
		var connection = from.get_connection_to(to)
		var segment = RouteSegment.instance().init(connection["curve"], carrier.get_path())
		
		add_child(segment)
		yield(segment, 'arrived')
		segment.queue_free()
		
func handle_pickups(station:Station, productions: Array):
	carrier.cargo = yield(station.dropoff(carrier.cargo), 'completed')
	carrier.update_cargo()

	for production in productions.slice(0, carrier.get_remaining_capacity()):
		yield(carrier.add_cargo(production.produces), 'completed')
	carrier.update_cargo()
