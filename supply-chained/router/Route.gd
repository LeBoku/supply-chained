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
		var step = steps[step_index] as RouteStep
		
		if len(step.exchanges) > 0:
			yield(handle_pickups(step), 'completed')

		var next_index = step_index + 1
		if next_index > len(steps) - 1:
			if repeats:
				next_index = 0
			else:
				break
		
		yield(travel(steps[step_index].station, steps[next_index].station), 'completed')
		step_index = next_index
	
	emit_signal("finished_route", steps[step_index].station)
		
func travel(from: Station, to: Station):
	yield(get_tree().create_timer(0), "timeout")

	if from != to:
		var connection = from.get_connection_to(to)
		var segment = RouteSegment.instance().init(connection["curve"], carrier.get_path())
		
		add_child(segment)
		yield(segment, 'arrived')
		segment.queue_free()
		
func handle_pickups(step: RouteStep):
	for exchange in step.exchanges:
		yield(handle_pickup(step.station, exchange[0], exchange[1], exchange[2]), "completed")

func handle_pickup(station: Station, list, cargo: String, pickup: bool):
	if pickup:
		yield(carrier.add_cargo(cargo), "completed")
	else:
		yield(carrier.remove_cargo(cargo), "completed")

func finish():
	active = false
	var current_station = yield(self, "finished_route")
	queue_free()
	
	return current_station
