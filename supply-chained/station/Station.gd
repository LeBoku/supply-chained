extends Position2D
class_name Station

const Util = preload("res://util/Util.gd")
export var wants = PoolStringArray()

var out_connections = []

onready var route_builder = get_node('/root/RouteBuilder')

func _ready():
	$Wants.initialize_cargo(wants)

	for production in Util.get_children_with_group(self, "Production"):
		wants.append_array(production.requires)

func get_connected_stations():
	var stations = []
	for conn in out_connections:
		stations.append(conn["station"])
		
	return stations

func get_connection_to(station:Station):
	for conn in out_connections:
		if conn["station"] == station:
			return conn

func dropoff(carrier):
	yield(get_tree().create_timer(0), "timeout")
	
	for r in wants:
		if carrier.cargo.has(r):
			carrier.remove_cargo(r)
			yield(get_tree().create_timer(1), "timeout")
	
