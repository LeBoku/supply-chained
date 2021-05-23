extends Position2D
class_name Station

const Util = preload("res://util/Util.gd")

var out_connections = []

onready var route_builder = get_node('/root/RouteBuilder')

func _ready():
	$Visual/Tween.interpolate_property($Visual, "scale:x", 0.2, 0.3, .3)
	$Visual/Tween.interpolate_property($Visual, "scale:y", 0.2, 0.3, .3)

func set_enabled(enabled):
	$Visual/Tween.set_active(enabled)

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
	
	var i = rand_range(0, len(cargo)*2)
	if i<len(cargo) and cargo[i] != null:
		cargo[i] = null
		timeout=2
		
	yield(get_tree().create_timer(timeout), "timeout")
	return cargo
