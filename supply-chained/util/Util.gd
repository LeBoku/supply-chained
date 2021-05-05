static func remove_children(node: Node):
	for child in node.get_children():
			node.remove_child(child)
