extends Node

class_name CargoExchange

var cargo: String
var pickup: bool

func initialize(cargo:String, pickup:bool):
	self.cargo = cargo
	self.pickup = pickup

	return self
	
func get_identifier():
	return str(pickup) + str(cargo)

func is_same(other: CargoExchange):
	return other != null and get_identifier() == other.get_identifier()
