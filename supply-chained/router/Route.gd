extends Node2D

const RouteSegment = preload("res://router/RouteSegment.tscn")

var stations: Array
var carrier: Node2D
var pickups: Dictionary

func init(stations: Array, carrier:Node2D, pickups:Dictionary):
	self.stations = stations
	self.carrier = carrier
	self.pickups = pickups
	return self

func start():
	var index = 0
	
	while is_instance_valid(self):
		yield(handle_pickups(index), 'completed')

		var next_index = index + 1
		if next_index > len(stations)-1:
			next_index=0
		
		yield(travel(stations[index], stations[next_index]), 'completed')
		index = next_index
		
func travel(from: Station, to: Station):
		var connection = from.get_connection_to(to)
		var segment = RouteSegment.instance().init(connection["curve"], carrier.get_path())
		
		add_child(segment)
		yield(segment, 'arrived')
		segment.queue_free()
		
func handle_pickups(index: int):
	if pickups.has(index):
		for p in pickups[index]:
			if p["dropoff"]:
				yield(stations[index].dropoff(p["id"], "Test"), "completed")
			else:
				var content = yield(stations[index].pickup(p["id"]), "completed")
				print(content)

	else:
		yield(get_tree().create_timer(0), "timeout")
	
