extends Position2D
class_name Station

const Util = preload("res://util/Util.gd")

signal selected(Station)

export var available_resources = PoolStringArray()
export var pickup_station_count = 2

var pickup_contents = {}
var out_connections = []

func _ready():
	$Visual/Tween.interpolate_property($Visual, "scale:x", 0.2, 0.3, .3)
	$Visual/Tween.interpolate_property($Visual, "scale:y", 0.2, 0.3, .3)
	
	set_pickup_stations(pickup_station_count)

func set_enabled(enabled):
	$Button.disabled = !enabled
	$Visual/Tween.set_active(enabled)
	
	if !enabled:
		$PickupPoints.visible = false
	
func pickup(id: String):
	yield(get_tree().create_timer(2), "timeout")
	return pickup_contents[id]

func dropoff(id: String, content: String):
	pickup_contents[id] = content

func show_pickup_panel():
	$PickupPoints.visible = true
	
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

func set_pickup_stations(count: int):
	Util.remove_children($PickupPoints)
	$PickupPoints.columns = round(sqrt(count))

	for i in range(count):
		var button = Button.new()
		var id = str(i + 1)
		button.text = id
		
		$PickupPoints.add_child(button)

		if not pickup_contents.has(id):
			pickup_contents[id] = null

		button.connect("pressed", get_node('/root/RouteBuilder'), "add_pickup_point", [id])
