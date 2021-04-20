extends Node2D

const RouteSegment = preload("res://Route/RouteSegment.tscn")

var stations

func init(stations: Array):
	self.stations = stations
	return self

func start():
	var index = 0
	while is_instance_valid(self):
		var next_index = index + 1
		if next_index > len(stations)-1:
			next_index=0
		
		var station = stations[index] as Station
		var next_station = stations[next_index] as Station
		
		var connection = station.get_connection_to(next_station)
		var segment = RouteSegment.instance().init(connection["curve"])
		
		add_child(segment)
		yield(segment, 'arrived')
		segment.queue_free()
		index = next_index

