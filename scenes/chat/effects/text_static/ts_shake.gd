extends TS_Effect
class_name TS_Shake

var pos = Vector2(0,0)



func init(params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass

func instance():
	self

func apply(Character: Character):
	# this method should execute character logic, may be ran more than once in loop
	pos = Vector2(rand_range(-1,1), rand_range(-1,1))
	Character.get_label().set_position(pos)


func run_once():
	# when effect is initialized (appended to Character) the Character
	# runs this.
	# if true, the effect is executed immediately and discarded.
	# if false, the effect will be executed in the process loop after initialization 
	return false
