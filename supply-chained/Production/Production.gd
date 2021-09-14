extends Node2D

class_name Production

const Util = preload("res://util/Util.gd")

signal produced

export var requires: PoolStringArray = ["labor"]
export var produces: PoolStringArray = ["exhausted-labor"]
export var time = 0

onready var cargo_helper = $"/root/CargoHelper"

var storage: StationStorage
var is_producing = false

func _ready():
	add_to_group("Production")
	set_enabled(false)
	
	$Connector.visible = true
	$Connector.add_point(Vector2())
	$Connector.add_point(-position)
	
	$Requirements.initialize_cargo(requires)
	$Produces.initialize_cargo(produces)

func init(time:int, requires:Array, produces:Array):
	self.time = time
	self.requires = PoolStringArray(requires)
	self.produces = PoolStringArray(produces)
	return self

func set_enabled(enabled):
	pass
	
func _on_cargo_selected(cargo: String, pickup: bool = false):
	$"/root/RouteBuilder".add_step(get_parent(), CargoExchange.new().initialize(cargo, pickup))

func connect_storage(storage: StationStorage):
	self.storage = storage
	storage.connect("changed", self, "_on_storage_changed")
	
func _on_storage_changed():
	if not is_producing and has_all_requirements():
		produce()

func has_all_requirements():
	for r_group in Util.group(requires).values():
		for r in r_group:
			if not storage.has(r_group[0], len(r_group)):
				return false

	return true
	
func produce():
	is_producing = true

	for r in requires:
		var removed = storage.remove_type(r)
		removed.queue_free()
	
	yield(get_tree().create_timer(time), "timeout")
	
	for p in produces:
		while not storage.has_empty_space():
			yield(storage, "changed")
		
		storage.add(cargo_helper.create_cargo(p))
		
	emit_signal("produced")
	is_producing = false

	_on_storage_changed()
