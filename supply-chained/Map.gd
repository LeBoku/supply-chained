extends Node2D

signal station_selected(Station)

func _ready():
	pass # Replace with function body.

func set_stations_enabled(enabled:bool = true):
	for s in get_tree().get_nodes_in_group('Station'):
		var station := s as Station
		station.set_enabled(enabled)

func _on_Mine_selected(station: Station):
	emit_signal("station_selected", station)
