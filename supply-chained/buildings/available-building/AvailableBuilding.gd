extends HBoxContainer

signal selected (type)

onready var store =  $"/root/BuildingStore"
onready var max_description_lines = $Details/Description.max_lines_visible

var type
var mouse_over = false

func init(type):
	self.type = type
	return self

func _ready():
	var data = store.get(type)
	$Details/Name.text = data.label
	$Details/Description.text = data.description
	$Icon.texture = data.icon

func _gui_input(_event):
	if mouse_over and Input.is_action_just_pressed("Activate"):
		emit_signal("selected", type)

func _mouse_exited():
	mouse_over = false

func _on_Description_mouse_entered():
	$Details/Description.max_lines_visible = -1

func _on_Description_mouse_exited():
	$Details/Description.max_lines_visible = max_description_lines

func _mouse_over_changed(state:bool):
	mouse_over = state
