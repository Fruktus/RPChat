extends T_Effect
class_name T_Color

var color: Color



func init(params: Dictionary):
	self.color = Color(params['macros'][0])  # FIXME this kinda does not look like the right way to pass this


func instance():
	return self


func apply(Character: Character):
	Character.get_label().add_theme_color_override("default_color", self.color)


func run_once():
	return true
