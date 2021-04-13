extends Line2D

export var stationA: NodePath
export var stationB: NodePath

func _ready():
	var statA = get_node(stationA) as Station
	var statB = get_node(stationB) as Station

	self.points[0] = statA.global_position
	self.points[self.points.size()-1] = statB.global_position

	var curve = Curve2D.new()
	var curve_reversed = Curve2D.new()
	
	for point in self.points:
		curve.add_point(point)
		curve_reversed.add_point(point,Vector2(), Vector2(),0)

	statA.out_connections.append({"curve":curve,"station": statB})
	statB.out_connections.append({"curve":curve_reversed,"station": statA})
