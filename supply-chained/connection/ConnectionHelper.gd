extends Line2D

onready var game_state = $"/root/GameState"

func _ready():
	var statA = game_state.get_station_at_point(points[0])
	var statB = game_state.get_station_at_point(points[-1])

	points[0] = statA.position
	points[-1] = statB.position

	var curve = Curve2D.new()
	var curve_reversed = Curve2D.new()
	
	for point in points:
		curve.add_point(point)
		curve_reversed.add_point(point, Vector2(), Vector2(), 0)

	statA.out_connections.append({"curve":curve,"station": statB})
	statB.out_connections.append({"curve":curve_reversed,"station": statA})
