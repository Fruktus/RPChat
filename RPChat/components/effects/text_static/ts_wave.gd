extends TS_Effect
class_name TS_Wave
# All of the text-static effects have to implement these methods

var x = 0
var amp = 10



func init(_params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass

func instance():
	var new_inst = TS_Wave.new()
	new_inst.amp = self.amp
	new_inst.x = self.x 
	
	self.x += 0.1
	return new_inst

func apply(Character: Character):
	# this method should execute character logic, may be ran more than once in loop
	Character.get_label().set_position(Vector2(0, self.amp * sin(Time.get_ticks_msec() * 0.01 + x)))  # TODO check if best way to get time


func run_once():
	# when effect is initialized (appended to Character) the Character
	# runs this.
	# if true, the effect is executed immediately and discarded.
	# if false, the effect will be executed in the process loop after initialization 
	return false
