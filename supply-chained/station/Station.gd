extends Position2D
class_name Station

const Util = preload("res://util/Util.gd")
export var wants = PoolStringArray()
export var initial_storage = PoolStringArray(["", "", "", ""])

var out_connections = []

onready var route_builder = $"/root/RouteBuilder"
onready var storage = $Storage as StationStorage

func _ready():
	$Wants.initialize_cargo(wants)
	storage.initialize(initial_storage)

	for production in Util.get_children_with_group(self, "Production"):
		production.connect_storage(storage)

func get_connected_stations():
	var stations = []
	for conn in out_connections:
		stations.append(conn["station"])
		
	return stations

func get_connection_to(station:Station):
	for conn in out_connections:
		if conn["station"] == station:
			return conn

func _on_want_selected(cargo):
	$"/root/RouteBuilder".add_step(self, CargoExchange.new().initialize(cargo, false))
