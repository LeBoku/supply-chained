extends Node
const default_icon = preload("res://buildings/icons/building.png")

enum types { farm, gatheringSpot, lumberCamp }

func get_description(type):
	return buildings[type]["description"]

func get_label(type):
	return buildings[type]["label"]

func get_icon(type):
	return default_icon

var buildings = {
	types.farm: {
		"label": "Farm",
		"description": "Uses Labor to create Wheat"
	},
	types.gatheringSpot: {
		"label": "Gathering Spot",
		"description": "Allow hungry Workers to search for their own food"
	},
	types.lumberCamp: {
		"label": "Lumber Camp",
		"description": "Allows collecting of Wood"
	}
}
