extends Position2D
class_name Station

const Util = preload("res://util/Util.gd")

export var requires = PoolStringArray()
var out_connections = []

onready var route_builder = get_node('/root/RouteBuilder')

func get_connected_stations():
	var stations = []
	for conn in out_connections:
		stations.append(conn["station"])
		
	return stations

func get_connection_to(station:Station):
	for conn in out_connections:
		if conn["station"] == station:
			return conn

func dropoff(cargo:Array):
	var timeout = 0
	
	for r in requires:
		if cargo.has(r):
			timeout += 1
			cargo[cargo.find(r)] = null
			
	yield(get_tree().create_timer(timeout), "timeout")
	return cargo
