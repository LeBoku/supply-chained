const YieldUtil = preload("res://util/YieldUtil.gd")

static func get_children_with_group(node: Node, group:String):
	var children = []
	
	for child in node.get_children():
		if child.is_in_group(group):
			children.append(child)
			
	return children

static func remove_children(node: Node, exclude: Array = []):
	for child in node.get_children():
		if not exclude.has(child):
			node.remove_child(child)

static func propagate_signal(node: Node, signal_name: String, to_node:Node, to_signal_name:String, arguments:Array=[]):
	node.connect(signal_name, to_node, "emit_signal", [to_signal_name] + arguments)

static func get_as_awaitables(nodes: Array, signal_name: String):
	var awaitables = []
	for node in nodes:
		awaitables.append([node, signal_name])
	return awaitables

static func group(list: Array):
	var groups = {}
	
	for item in list:
		groups[item] = [] if not groups.has(item) else groups[item]
		groups[item].append(item)

	return groups

static func yield_await_first(awaitables: Array):
	var yielder = YieldUtil.new()
	yield(yielder.race(awaitables), 'completed')
	
static func yield_await_all(awaitables: Array):
	var yielder = YieldUtil.new()
	yield(yielder.all(awaitables), 'completed')
