static func remove_children(node: Node):
	for child in node.get_children():
			node.remove_child(child)

static func propagate_signal(node: Node, signal_name: String, to_node:Node, to_signal_name:String, arguments:Array=[]):
	node.connect(signal_name, to_node, "emit_signal", [to_signal_name]+ arguments)
