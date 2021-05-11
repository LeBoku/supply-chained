extends Node

signal one_finished
signal all_finished

var active_count = 0

func race(awaitables: Array):
	start(awaitables)
	yield(self, "one_finished")

func all(awaitables: Array):
	start(awaitables)
	yield(self, "all_finished")

func start(awaitables: Array):
	for awaitable in awaitables:
		var node := awaitable[0] as Node
		var signal_name := awaitable[1] as String
		
		active_count += 1
		node.connect(signal_name, self, "on_finished_one", [], CONNECT_ONESHOT)

func on_finished_one():
	emit_signal("one_finished")
	active_count -= 1
	
	if active_count == 0:
		emit_signal('all_finished')
		self.queue_free()
