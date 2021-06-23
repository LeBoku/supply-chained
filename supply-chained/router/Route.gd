extends Node2D

class_name Route

signal finished_route(Station)

const RouteSegment = preload("res://router/RouteSegment.tscn")

var steps: Array
var repeats = true

var carrier: Carrier
var active = false

func init(steps:Array, repeats = true):
	self.steps = steps
	self.repeats = repeats
	return self
	
func add_carrier(carrier: Carrier):
	self.carrier = carrier
	carrier.current_route = self
	carrier.update_route()
	return self

func start():
	active = true
	var step_index = 0
	
	while active and is_instance_valid(self):
		var step = steps[step_index]
		
		if len(step[1])>0:
			yield(handle_pickups(step[0], step[1]), 'completed')

		var next_index = step_index + 1
		if next_index > len(steps) - 1:
			if repeats:
				next_index = 0
			else:
				break
		
		yield(travel(steps[step_index][0], steps[next_index][0]), 'completed')
		step_index = next_index
	
	emit_signal("finished_route", steps[step_index][0])
		
func travel(from: Station, to: Station):
		var connection = from.get_connection_to(to)
		var segment = RouteSegment.instance().init(connection["curve"], carrier.get_path())
		
		add_child(segment)
		yield(segment, 'arrived')
		segment.queue_free()
		
func handle_pickups(station:Station, productions: Array):
	yield(station.dropoff(carrier), 'completed')

	for production in productions.slice(0, carrier.get_remaining_capacity()):
		yield(carrier.add_cargo(production.produces), 'completed')

func finish():
	active = false
	var current_station = yield(self, "finished_route")
	queue_free()
	
	return current_station
