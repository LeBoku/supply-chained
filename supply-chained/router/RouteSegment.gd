extends Path2D

signal arrived
var next_segment
var speed = 10

func init(curve, carrier):
	self.curve = curve
	$Follower/Remote.remote_path = carrier
	return self

func _process(delta):
	$Follower.offset += delta * speed
	
	if $Follower.unit_offset >= 1:
		emit_signal("arrived")

