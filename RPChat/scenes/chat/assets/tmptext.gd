extends Label

var effects: Array

func _ready() -> void:
	set_process(false)

var pos = Vector2(0,0)

func _process(delta: float) -> void:
	pos += Vector2(randf_range(-1,1), randf_range(-1,1))
	self.set_position(pos)
#	self.set_position(Vector2(rand_range(-1,1), rand_range(-1,1)))

func set_character(text):
	self.text = text
