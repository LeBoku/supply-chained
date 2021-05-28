extends Line2D

func _ready():
	var statA = get_station_at_point(points[0])
	var statB = get_station_at_point(points[points.size()-1])

	var curve = Curve2D.new()
	var curve_reversed = Curve2D.new()
	
	for point in points:
		curve.add_point(point)
		curve_reversed.add_point(point,Vector2(), Vector2(),0)

	statA.out_connections.append({"curve":curve,"station": statB})
	statB.out_connections.append({"curve":curve_reversed,"station": statA})

func get_station_at_point(point: Vector2, buffer:int = 5):
	var stations = get_tree().get_nodes_in_group('Station')
	for s in stations:
		var station := s as Station
		if point.distance_to(station.position) <= buffer:
			return station
