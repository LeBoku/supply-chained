extends Node2D

const RouteSegment = preload("res://Route/RouteSegment.tscn")

var stations: Array
var carrier: Node2D

func init(stations: Array, carrier:Node2D):
	self.stations = stations
	self.carrier = carrier
	return self

func start():
	var index = 0
	
	while is_instance_valid(self):
		var next_index = index + 1
		if next_index > len(stations)-1:
			next_index=0
		
		yield(travel(stations[index],stations[next_index]), 'completed')
		index = next_index
		
func travel(from: Station, to: Station):
		var connection = from.get_connection_to(to)
		var segment = RouteSegment.instance().init(connection["curve"], carrier.get_path())
		
		add_child(segment)
		yield(segment, 'arrived')
		segment.queue_free()

