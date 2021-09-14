extends Node
const default_icon = preload("res://buildings/icons/building.png")

enum types { farm, gatheringSpot, lumberCamp }

func get_description(type):
	return buildings[type]["description"]

func get_label(type):
	return buildings[type]["label"]

func get_icon(type):
	return default_icon

func get_building_steps(type):
	return buildings[type]["building-steps"] as Array
	
func get_productions(type):
	return buildings[type]["productions"] as Array

var buildings = {
	types.farm: {
		"label": "Farm",
		"description": "Uses Labor to create Wheat",
		"building-steps": [[5, ["labor", "wood"], ["labor-exhausted"]]],
		"productions": [[5, ["labor"], ["wheat", "labor-exhausted"]]]
	},
	types.gatheringSpot: {
		"label": "Gathering Spot",
		"description": "Allow hungry Workers to search for their own food",
		"building-steps": [],
		"productions": [[30, ["labor-exhausted"], ["labor"]]]
	},
	types.lumberCamp: {
		"label": "Lumber Camp",
		"description": "Allows collecting of Wood",
		"building-steps": [[10, ["labor"], ["labor-exhausted"]]],
		
		"productions": [[10, ["labor"], ["wood", "labor-exhausted"]]]
	}
}
