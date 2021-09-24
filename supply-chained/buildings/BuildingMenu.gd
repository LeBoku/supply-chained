extends Polygon2D

signal created_station(Station)

const Util = preload("res://util/Util.gd")
const Enums = preload("res://util/Enums.gd")
const AvailableBuilding = preload("res://buildings/available-building/AvailableBuilding.tscn")
const Station = preload("res://station/Station.tscn")
const Production = preload("res://production/Production.tscn")

onready var store =  $"/root/BuildingStore"
onready var game_state =  $"/root/GameState"

func _input(_event):
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
	var options = []
	var station = game_state.get_station_at_point(position)

	if station != null:
		options.append_array(store.get(station.building_type).upgrades)
		position = station.position
	else:
		for biome in game_state.get_biomes_at_point(position):
			options.append_array(get_buildings_for(biome))

	for option in options:
		var building = AvailableBuilding.instance().init(option)
		building.connect("selected", self, "_on_building_selected")
		$List.add_child(building)

func get_buildings_for(biome):
	if biome == Enums.Biomes.grassland:
		return [Enums.BuildingTypes.farm]
	elif biome == Enums.Biomes.forest:
		return [Enums.BuildingTypes.foodGathering, Enums.BuildingTypes.lumberCamp]
	elif biome == Enums.Biomes.rocks:
		return [Enums.BuildingTypes.stoneGathering]
	elif biome == Enums.Biomes.land:
		return [Enums.BuildingTypes.furnance]
	else:
		return []

func _on_building_selected(building_type):
	place_building(building_type)
	close()

func place_building(type):
	var station = Station.instance()
	station.position = position
	station.building_type = type
	
	emit_signal("created_station", station)
	var data = store.get(type)

	for step in data.building_steps:
		var prod = Production.instance().init(step[0], step[1], step[2])
		station.add_production(prod)
		yield(prod, "produced")
		prod.queue_free()
	
	for production in data.productions:
		var prod = Production.instance().init(production[0], production[1], production[2])
		station.add_production(prod)
		
