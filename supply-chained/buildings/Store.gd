extends Node
const default_icon = preload("res://buildings/icons/building.png")
const Enums = preload("res://util/Enums.gd")

func get_description(type):
	return buildings[type]["description"]

func get_label(type):
	return buildings[type]["label"]

func get_icon(type):
	return buildings[type]["icon"]

func get_building_steps(type):
	return buildings[type]["building-steps"] as Array
	
func get_productions(type):
	return buildings[type]["productions"] as Array
	
func get_upgrades(type):
	return buildings[type]["upgrades"] as Array

var buildings = {
	Enums.BuildingTypes.storage:{
		"label": "Storage",
		"description": "A place to store things",
		"building-steps": [],
		"productions": [],
		"icon": default_icon,
		"upgrades": []
	},
	Enums.BuildingTypes.farm: {
		"label": "Farm",
		"description": "Uses Labor to create Wheat",
		"building-steps": [[5, ["labor", "wood"], ["labor-exhausted"]]],
		"productions": [[5, ["labor"], ["wheat", "labor-exhausted"]]],
		"icon": default_icon,
		"upgrades": []
	},
	Enums.BuildingTypes.foodGathering: {
		"label": "Gathering Spot",
		"description": "Allow hungry Workers to search for their own food",
		"building-steps": [],
		"productions": [[30, ["labor-exhausted"], ["labor"]]],
		"icon": default_icon,
		"upgrades": []
	},
	Enums.BuildingTypes.lumberCamp: {
		"label": "Lumber Camp",
		"description": "Allows collecting of Wood",
		"building-steps": [[10, ["labor"], ["labor-exhausted"]]],
		"productions": [[10, ["labor"], ["wood", "labor-exhausted"]]],
		"icon": default_icon,
		"upgrades": []
	},
	Enums.BuildingTypes.stoneGathering: {
		"label": "Stone Gathering",
		"description": "Allows collecting of Stone",
		"building-steps": [[10, ["labor"], ["labor-exhausted"]]],
		"productions": [[10, ["labor"], ["stone", "labor-exhausted"]]],
		"icon": default_icon,
		"upgrades": []
	}
}
