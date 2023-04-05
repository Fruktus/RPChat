extends MarginContainer
class_name Character

var active_effects = []



func _ready() -> void:
	self.visible = false
	set_process(false)


func enable() -> void:
	if len(self.active_effects) > 0:
		set_process(true)
	self.visible = true


func init_effects(effects: Dictionary):
	# TODO apply all the effects, store them in array
	# effects should be kept since some of them will require being processed
	# TODO I should figure out some way to tell which are ran once and which should
	# be ran all the time
	for key in effects:
#		print(effects[key].can_instantiate())
		var effect = effects[key].instance()  # This is not Godot's instance kw, but effect's
		
		if effect.run_once():
			effect.apply(self)
		else:
			self.active_effects.append(effect)
		
#	if 'color' in effects:
#		$Label.add_color_override("font_color", ColorN(effects['color']))


func get_label():
	return $Label


func set_character(text):
	$Label.text = text


func _process(_delta: float) -> void:
	for effect in self.active_effects:
		effect.apply(self)
