extends Node

func get_stations():
	return get_tree().get_nodes_in_group('Station')

func get_station_at_point(point: Vector2, buffer:int = 5):
	for s in get_stations():
		var station := s as Station
		if point.distance_to(station.position) <= buffer:
			return station

func get_station_with_cargo(cargo):
	for s in get_stations():
		var station := s as Station
		if station.storage.stored_cargo.has(cargo):
			return station
