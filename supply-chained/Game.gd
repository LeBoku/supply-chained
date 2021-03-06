extends Node2D

const Route = preload("res://router/Route.tscn")
const CarierHud = preload("res://carriers/Hud.tscn")

onready var route_builder = get_node("/root/RouteBuilder")
onready var cargo_helper = get_node("/root/CargoHelper")
onready var globals = get_node("/root/Globals")

func _ready():
	for c in cargo_helper.existing_cargo:
		add_child(c)

	cargo_helper.connect("cargo_created", self, "add_child")
	
	for carrier in get_tree().get_nodes_in_group("carrier"):
		var hud = CarierHud.instance()
		hud.carrier = carrier
		hud.connect("carrier_selected", self, "_on_carrier_selected")
		$HUD/CarriersHud.add_child(hud)

func _on_carrier_selected(carrier: Carrier):
	var route = route_builder.build_route()
	carrier.update_temp_route(route)
	
	yield(route_builder, "route_finalized")
	
	if carrier.current_route != null:
		yield(self.finish_current_route(carrier, route), "completed")
	
	add_child(route)
	route.add_carrier(carrier).start()

func finish_current_route(carrier: Carrier, route: Route):
	var final_station = yield(carrier.current_route.finish(), "completed")
	var start_station = route.steps[0].station
	var temp_route = route_builder.get_temporary_route(final_station, start_station)
	
	add_child(temp_route)
	yield(temp_route.add_carrier(carrier, false).start(), "completed")
	temp_route.queue_free()


func _on_BuildingMenu_created_station(station: Station):
	add_child(station)
