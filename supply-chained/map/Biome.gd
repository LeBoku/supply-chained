tool
extends Polygon2D

class_name Biome

const Util = preload("res://util/Util.gd")

export(Util.Biomes) var kind setget set_kind

var biome_config = {
	Util.Biomes.land: [Color.yellowgreen, -10],
	Util.Biomes.grassland: [Color.greenyellow, 0],
	Util.Biomes.forest: [Color.darkgreen, 1],
	Util.Biomes.rocks: [Color.gray, 2],
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
