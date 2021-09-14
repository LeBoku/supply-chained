extends Polygon2D

signal created_station(Station)

const Util = preload("res://util/Util.gd")
const AvailableBuilding = preload("res://buildings/available-building/AvailableBuilding.tscn")
const Station = preload("res://station/Station.tscn")
const Production = preload("res://production/Production.tscn")

onready var store =  $"/root/BuildingStore"

func _input(event):
	if Input.is_action_just_pressed("OpenBuildingMenu"):
		open(get_global_mouse_position())
	if Input.is_action_just_pressed("CloseBuildingMenu"):
		close()
		
func open(target_position: Vector2):
	visible = true
	position = target_position
	set_build_options()
	
func close():
	visible = false

func set_build_options():
	Util.remove_children($List)
	for biome in $"/root/GameState".get_biomes_at_point(position):
		for building_type in get_buildings_for(biome):
			var building = AvailableBuilding.instance().init(building_type)
			building.connect("selected", self, "_on_building_selected")
			$List.add_child(building)

func get_buildings_for(biome):
	if biome == "grassland":
		return [store.types.farm]
	elif biome == "forest":
		return [store.types.gatheringSpot, store.types.lumberCamp]

func _on_building_selected(building_type):
	place_building(building_type)
	close()

func place_building(type):
	var station = Station.instance()
	station.position = position
	
	emit_signal("created_station", station)

	for step in store.get_building_steps(type):
		var prod = Production.instance().init(step[0], step[1], step[2])
		station.add_production(prod)
		yield(prod, "produced")
		prod.queue_free()
	
	for production in store.get_productions(type):
		var prod = Production.instance().init(production[0], production[1], production[2])
		station.add_production(prod)
		
