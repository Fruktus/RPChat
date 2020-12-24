extends MarginContainer


func init_effects(effects: Dictionary):
	# apply all the effects, store them in array
	if 'color' in effects:
		$Label.add_color_override("font_color", ColorN(effects['color']))

func set_character(text):
	$Label.text = text
#func _process(delta: float) -> void:
#	# make it 
#	pass


# TODO attach script to linecontainer, make it know how many actual characters
			# it has inside (may have more nodes than chars because tags)
			# create a method which would retrieve character based on its idx
			# independently from the line it is on

# TODO make method for appending characters
