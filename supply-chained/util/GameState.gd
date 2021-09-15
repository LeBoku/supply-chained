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

func get_biomes_at_point(point: Vector2):
	var biome_types = []
	for b in get_tree().get_nodes_in_group("biome"):
		var biome := b as Biome
		if Geometry.is_point_in_polygon(point, biome.polygon):
			biome_types.append(biome.kind)
			
	return biome_types
