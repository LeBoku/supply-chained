extends HBoxContainer

const AvailableBuilding = preload("res://buildings/available-building/AvailableBuilding.tscn")

func add_building(name: String, amount: int = 1):
	var building = get_building(name)
	building.amount = amount
	add_child(building)

func get_building(name):
	var building = AvailableBuilding.instance()
	building.building_name = name
	
	return building
