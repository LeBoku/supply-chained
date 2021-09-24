extends Node

const default_icon = preload("res://buildings/icons/building.png")

var label: String = ""
var description: String = ""
var building_steps: Array = []
var productions: Array = []
var icon: Texture = default_icon
var upgrades: Array = []

func init(label:String, description: String):
	self.label = label
	self.description = description
	return self

func add_production(time, input:Array, output: Array):
	productions.append([time, input, output])
	return self
	
func add_building_step(time, input:Array, output: Array):
	building_steps.append([time, input, output])
	return self
