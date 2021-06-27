extends Node

class_name RouteStep

var station: Station
var exchanges: Array = []

func initialize(station: Station):
	self.station = station

	return self

func add_exchange(exchange: Array):
	exchanges.append(exchange)
	exchanges.sort_custom(self, "sort_exchanges")

func sort_exchanges(a:Array, b:Array):
	return not a[2] if a[2] != b[2] else a[1] < b[1]
