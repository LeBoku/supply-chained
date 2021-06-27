extends Node

class_name RouteStep

var station: Station
var exchanges: Array = []

func initialize(station: Station):
	self.station = station

	return self

func add_exchange(exchange: CargoExchange):
	exchanges.append(exchange)
	exchanges.sort_custom(self, "sort_exchanges")

func sort_exchanges(a: CargoExchange, b: CargoExchange):
	return not a.pickup if a.pickup != b.pickup else a.cargo < b.cargo
