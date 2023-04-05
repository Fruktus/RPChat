extends TS_Effect
class_name TS_Shake

var pos = Vector2(0,0)



func init(_params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass

func instance():
	return self

func apply(Character: Character):
	# this method should execute character logic, may be ran more than once in loop
	pos = Vector2(randf_range(-1,1), randf_range(-1,1))  # FIXME will override any other position-related effect
	Character.get_label().set_position(pos)


func run_once():
	# when effect is initialized (appended to Character) the Character
	# runs this.
	# if true, the effect is executed immediately and discarded.
	# if false, the effect will be executed in the process loop after initialization 
	return false
