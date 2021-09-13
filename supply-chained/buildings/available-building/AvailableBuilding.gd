extends GridContainer

export var building_name: String
export var amount: int
export var building: PackedScene
export var icon: Texture

func _ready():
	$Name.text = building_name
	$Amount.text = str(amount) + "x"
	$Icon.texture = icon if icon != null else load("res://buildings/icons/building.png")
