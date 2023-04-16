extends Control
class_name Tag

var effects: Dictionary


func _ready() -> void:
	# TODO may not be needed
	set_process(false)

func init(tag_effects: Dictionary):
	self.effects = tag_effects
