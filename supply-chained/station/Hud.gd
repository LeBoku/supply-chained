extends GridContainer

const Util = preload("res://util/Util.gd")

var disabled = true

func ready():
	set_enabled(false)

func set_enabled(state: bool):
	disabled = !state
	for button in get_children():
		set_button_state(button)
		
func render(contents):
	Util.remove_children(self)
	columns = round(sqrt(len(contents)))

	for i in range(len(contents)):
		var content = contents[i]
		var button = Button.new()
		
		set_button_state(button)
		button.text = content if content != null else ' '
		add_child(button)

		button.connect("pressed", get_node('/root/RouteBuilder'), "add_pickup_point", [i])

func set_button_state(button: Button):
		button.disabled = disabled
		button.mouse_filter = MOUSE_FILTER_IGNORE if disabled else MOUSE_FILTER_PASS  
