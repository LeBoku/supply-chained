extends Position2D
class_name Station

const Util = preload("res://util/Util.gd")

var out_connections = []
var requires = PoolStringArray()

onready var route_builder = get_node('/root/RouteBuilder')

func _ready():
	for production in Util.get_children_with_group(self, "Production"):
		requires.append_array(production.requires)

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
