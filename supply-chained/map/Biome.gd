tool
extends Polygon2D

class_name Biome

const Util = preload("res://util/Util.gd")
const Enums = preload("res://util/Enums.gd")

export(Enums.Biomes) var kind setget set_kind

var biome_config = {
	Enums.Biomes.land: [Color.yellowgreen, -10],
	Enums.Biomes.grassland: [Color.greenyellow, 0],
	Enums.Biomes.forest: [Color.darkgreen, 1],
	Enums.Biomes.rocks: [Color.gray, 2],
}

func _ready():
	set_kind(kind)

func set_kind(value):
	kind = value
	if biome_config.has(kind):
		var config = biome_config[kind]
		color = config[0]
		z_index = config[1]

	elif not Engine.editor_hint:
		push_error("invalid biome type "+kind)
