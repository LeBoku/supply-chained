extends Node2D

class_name Route

signal changed
signal finished_route(Station)

const RouteSegment = preload("res://router/RouteSegment.tscn")

var steps: Array = []
var repeats = true

var carrier: Carrier
var active = false
var editing = false
var exchange_time = 1

func init(steps:Array, repeats = true):
	self.steps = steps
	self.repeats = repeats
	return self
	
func add_steps(steps: Array):
	self.steps.append_array(steps)
	emit_signal("changed")
	
func add_exchange(step_index:int, exchange: CargoExchange):
	steps[step_index].add_exchange(exchange)

	emit_signal("changed")

func add_carrier(carrier: Carrier, clear_temp_route = true):
	self.carrier = carrier
	carrier.update_route(self, clear_temp_route)
	return self

func start():
	active = true
	var step_index = 0
	
	while active and is_instance_valid(self):
		var step = steps[step_index] as RouteStep
		
		if len(step.exchanges) > 0:
			yield(handle_exchanges(step), 'completed')

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
		
func handle_exchanges(step: RouteStep):
	for exchange in step.exchanges:
		yield(handle_pickup(step.station, exchange), "completed")

func handle_pickup(station: Station, exchange: CargoExchange):
	var time = 0
	
	var exchanged = false
	if exchange.pickup:
		exchanged = exchange(exchange.cargo, station.storage, carrier)
	else:
		exchanged = exchange(exchange.cargo, carrier, station.storage)
	
	if exchanged:
		time = exchange_time

	yield(get_tree().create_timer(time), "timeout")
	
func finish():
	active = false
	var current_station = yield(self, "finished_route")
	queue_free()
	
	return current_station
	
func exchange(cargo:String, from: CargoStorage, to: CargoStorage):
	if from.has(cargo) and to.has_empty_space():
		to.add(cargo)
		from.remove(cargo)

		return true
	else:
		return false
	
