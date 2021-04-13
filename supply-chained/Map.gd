extends Node2D

signal station_selected(Station)

func _ready():
	for s in get_tree().get_nodes_in_group('Station'):
		var station := s as Station
		station.connect("selected", self, "_on_station_selected")

func _on_station_selected(station: Station):
	emit_signal("station_selected", station)
