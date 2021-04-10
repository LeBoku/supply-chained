extends Node2D

func _on_train_pressed():
	$Map.set_stations_enabled(true)
	var station = yield($Map, "station_selected")
	$Map.set_stations_enabled(false)
