extends T_Effect
class_name T_Wave
# All of the text-static effects have to implement these methods

var x = 0
var amp = 10



func _init():
	self.run_once = false
	self.description = 'Makes the text move up and down in a wave pattern'
	self.default_settings = {
		'amp': {
			'value': 10,
			'help': 'Determines the amplitude of the wave effect'
		}
	}


func init(_params: Dictionary):
	pass

func instance():
	var new_inst = T_Wave.new()
	new_inst.amp = self.amp
	new_inst.x = self.x 
	
	self.x += 0.1
	return new_inst

func apply(Character: Character):
	# this method should execute character logic, may be ran more than once in loop
	Character.get_label().set_position(Vector2(0, self.amp * sin(Time.get_ticks_msec() * 0.01 + x)))  # TODO check if best way to get time
