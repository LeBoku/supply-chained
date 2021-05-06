extends Timer

signal resources_produced(target, resource)

export var resources: PoolStringArray = []
export var resources_targets: PoolStringArray = []
export var production_time = 2

func _ready():
	start_production()

func start_production():
	start(production_time)
	yield(self, "timeout")
	finalize_production()

func finalize_production():
	for index in range(len(resources)):
		emit_signal("resources_produced", resources_targets[index], resources[index])
	
	start_production()
