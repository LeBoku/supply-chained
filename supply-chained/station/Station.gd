extends Position2D
class_name Station

const Util = preload("res://util/Util.gd")

signal selected(Station)
signal pickups_changed

export var pickup_contents = []
var out_connections = []

onready var route_builder = get_node('/root/RouteBuilder')

func _ready():
	$Visual/Tween.interpolate_property($Visual, "scale:x", 0.2, 0.3, .3)
	$Visual/Tween.interpolate_property($Visual, "scale:y", 0.2, 0.3, .3)
	
	$PickupPoints.render(pickup_contents)

func set_enabled(enabled):
	$Visual/Tween.set_active(enabled)
	
func set_focused(state: bool):
	if len(pickup_contents) == 1:
		$"/root/RouteBuilder".add_pickup_point(0)
	else:
		$PickupPoints.set_enabled(state)
	
func has_space(index:int):
	return pickup_contents[index] == null
	
func pickup(index: int):
	yield(get_tree().create_timer(2), "timeout")
	return pickup_contents[index]

func dropoff(index: int, content):
	pickup_contents[index] = content
	$PickupPoints.render(pickup_contents)
	emit_signal("pickups_changed")
	
func get_connected_stations():
	var stations = []
	for conn in out_connections:
		stations.append(conn["station"])
		
	return stations
	
func get_connection_to(station:Station):
	for conn in out_connections:
		if conn["station"] == station:
			return conn

func _on_pressed():
	emit_signal("selected", self)

func _on_resources_produced(target, resource):
	dropoff(target, resource)
