extends MarginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# TODO for removal, tests only
var tmp_color_table = {'red': Color(1,0,0), 'white': Color(1,1,1), 'black': Color(0,0,0)}

func init_effects(effects: Dictionary):
	if 'color' in effects:
		$Label.add_color_override("font_color", tmp_color_table[effects['color']])
