static func remove_children(node: Node):
	for child in node.get_children():
			node.remove_child(child)

static func propagate_signal(node: Node, signal_name: String, to_node:Node, to_signal_name:String, arguments:Array=[]):
	node.connect(signal_name, to_node, "emit_signal", [to_signal_name] + arguments)

static func yield_await_first(awaitables: Array):
	var yielder = load("res://util/YieldUtil.gd").new()
	yield(yielder.race(awaitables), 'completed')
	
static func yield_await_all(awaitables: Array):
	var yielder = load("res://util/YieldUtil.gd").new()
	yield(yielder.all(awaitables), 'completed')
