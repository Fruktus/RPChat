extends TS_Effect
class_name TS_Color

var color: Color



func init(params: Dictionary):
	self.color = ColorN(params.get('ts_color', 'white'))


func instance():
	return self


func apply(Character: Character):
	Character.get_label().add_color_override("font_color", self.color)


func run_once():
	return true
