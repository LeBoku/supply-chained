extends Node2D

class_name Cargo

onready var game_state = $"/root/GameState"
onready var route_builder = $"/root/RouteBuilder"

var type: String
var texture: Texture
var selected = false

var movement_speed = 25 # Distance per second

func _ready():
	add_to_group("Cargo")
	$Icon.texture = texture

func _input(_event):
	if Input.is_action_just_pressed("Activate") and mouse_is_over():
		selected = true;
	
	elif Input.is_action_just_released("Activate"):
		if selected:
			move_to_position(get_global_mouse_position())

		selected = false;
	
	elif selected:
		$PathIndicator.visible = true
		$PathIndicator.points[1] = get_local_mouse_position()
	
	else:
		$PathIndicator.visible = false

func init(type:String, texture:Texture):
	self.type = type
	self.texture = texture
	
	return self
	
func is_type(type: String):
	return self.type == type
	
func mouse_is_over():
	return get_local_mouse_position().abs().length() < 30

func move_to_position(position: Vector2):
	var station = game_state.get_station_at_point(position)

	if station != null:
		move_to_station(station)
	
func move_to_station(station: Position2D):
	var current_station = game_state.get_station_with_cargo(self)
	if current_station:
		current_station.storage.remove_cargo(self)
		
	var time = (station.position - position).length() / movement_speed
		
	$MovementTween.interpolate_property(self, "position", position, station.position, time)
	$MovementTween.start()

func _on_Movement_completed():
	var station = game_state.get_station_at_point(position)
	if station != null:
		station.storage.add(self)
