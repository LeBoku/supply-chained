extends Node
const default_icon = preload("res://buildings/icons/building.png")
const Enums = preload("res://util/Enums.gd")
const BuildingData = preload("res://buildings/BuildingData.gd")

func get(type) -> BuildingData:
	return buildings[type]

var buildings = {
	Enums.BuildingTypes.storage: BuildingData.new() \
		.init("Storage", "A place to store things"),
		
	Enums.BuildingTypes.farm: BuildingData.new() \
		.init("Farm", "Uses Labor to create Wheat") \
		.add_production(5, ["labor"], ["wheat", "labor-exhausted"]) \
		.add_building_step(5, ["labor", "wood"], ["labor-exhausted"]),
		
	Enums.BuildingTypes.foodGathering: BuildingData.new() \
		.init("Gathering Spot", "Allow hungry Workers to search for their own food") \
		.add_production(30, ["labor-exhausted"], ["labor"]),
		
	Enums.BuildingTypes.lumberCamp: BuildingData.new() \
		.init("Lumber Camp", "Allows collecting of Wood") \
		.add_building_step(10, ["labor"], ["labor-exhausted"]) \
		.add_production(10, ["labor"], ["wood", "labor-exhausted"]),

	Enums.BuildingTypes.stoneGathering: BuildingData.new() \
		.init("Stone Gathering", "Allows collecting of Stone") \
		.add_building_step(10, ["labor"], ["labor-exhausted"]) \
		.add_production(10, ["labor"], ["stone", "labor-exhausted"])
}
