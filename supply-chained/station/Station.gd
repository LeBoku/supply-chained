extends Position2D
class_name Station

signal selected(Station)

export var available_resources = PoolStringArray()

var out_connections = []

func _ready():
	$Visual/Tween.interpolate_property($Visual, "scale:x", 0.2, 0.3, .3)
	$Visual/Tween.interpolate_property($Visual, "scale:y", 0.2, 0.3, .3)

func set_enabled(enabled):
	$Button.disabled = !enabled
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

func _on_pressed():
	emit_signal("selected", self)
