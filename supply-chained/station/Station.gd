extends Position2D
class_name Station

onready var store =  $"/root/BuildingStore"

const Util = preload("res://util/Util.gd")
const Enums = preload("res://util/Enums.gd")
export var initial_storage = PoolStringArray(["", "", "", ""])
export(Enums.BuildingTypes) var building_type = Enums.BuildingTypes.storage

var out_connections = []

onready var route_builder = $"/root/RouteBuilder"
onready var storage = $Storage as StationStorage

func _ready():
	storage.initialize(initial_storage)

	for production in Util.get_children_with_group(self, "Production"):
		add_production(production)

func add_production(production):
	if not production.is_inside_tree():
		add_child(production)
		production.position = Vector2(15,10)

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
