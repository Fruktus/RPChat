extends MarginContainer


func init_effects(effects: Dictionary):
	# apply all the effects, store them in array
	if 'color' in effects:
		$Label.add_color_override("font_color", ColorN(effects['color']))

#func _process(delta: float) -> void:
#	# make it 
#	pass
