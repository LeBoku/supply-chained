extends Position2D
class_name Station

const Util = preload("res://util/Util.gd")

var out_connections = []
var requires = PoolStringArray()

onready var route_builder = get_node('/root/RouteBuilder')

func _ready():
	for production in Util.get_children_with_group(self, "Production"):
		requires.append_array(production.requires)
	
	display_requirements()

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

func display_requirements():
	$Requirements.visible = len(requires) > 0
	for r in requires:
		var icon = $"/root/MaterialHelper".get_icon(r)
		var sprite = $Requirements/Box/Template.duplicate()
		sprite.texture = icon
		$Requirements/Box.add_child(sprite)

	$Requirements/Box/Template.visible=false
