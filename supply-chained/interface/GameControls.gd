extends HBoxContainer

func set_game_speed(speed: float, button: Button):
	Engine.time_scale = speed
	
	$Stop.disabled = false
	$Normal.disabled = false
	$Faster.disabled = false
	$Fastest.disabled = false
	
	button.disabled = true


func _on_Stop_pressed():
	set_game_speed(0, $Stop)

func _on_Normal_pressed():
	set_game_speed(1, $Normal)

func _on_Faster_pressed():
	set_game_speed(2, $Faster)

func _on_Fastest_pressed():
	set_game_speed(4, $Fastest)
