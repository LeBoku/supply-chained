extends Camera2D

export var speed = 500
export var max_zoom = 1
export var min_zoom = 0.2

func _process(delta: float):
	handle_movement(delta)
	handle_zoom(delta)

func handle_movement(delta:float):
	var direction = Vector2.ZERO
	
	if Input.is_action_pressed("ui_down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("ui_up"):
		direction += Vector2.UP
	if Input.is_action_pressed("ui_left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		direction += Vector2.RIGHT
		
	if direction.length() > 0:
		position += direction.normalized() * delta * speed * zoom.x

func handle_zoom(delta: float):
	var zoom_change = 0.0
	
	if Input.is_action_pressed("camera_zoom_in"):
		zoom_change += .5
	if Input.is_action_pressed("camera_zoom_out"):
		zoom_change -= .5

	zoom_change *= delta

	zoom.x = clamp(zoom.x + zoom_change, min_zoom, max_zoom)
	zoom.y = clamp(zoom.y + zoom_change, min_zoom, max_zoom)

	
