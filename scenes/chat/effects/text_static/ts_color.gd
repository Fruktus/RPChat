extends TS_Effect
class_name TS_Color

var color: Color



func init(params: Dictionary):
	self.color = ColorN(params['macros'][0])  # FIXME this kinda does not look like the right way to pass this


func instance():
	return self


func apply(Character: Character):
	Character.get_label().add_color_override("font_color", self.color)


func run_once():
	return true
