extends Node

class_name RouteStep

var station: Station
var exchanges: Array = []

func initialize(station: Station):
	self.station = station

	return self

func add_exchange(exchange: Array):
	exchanges.append(exchange)
