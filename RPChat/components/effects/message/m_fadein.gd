extends M_Effect
class_name M_Fadein
# TODO this effect needs to be placed at the end of the text (if the message is to be shown whole at once)
# Otherwise, empty container will fade in and then fill with text
# This may or may not need fixing, could be solved by adding a type of effects that can be ran concurrently (non-blocking)

var _duration = 3
var _time_running = 0
var _message: Message



func init(params: Dictionary, message: Message):
	self._message = message
	self._message.modulate.a = 0
	
	if params['macros']:
		self._duration = float(params['macros'][0])
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present


func instance():  # TODO probably won't be needed
	return self


func apply(delta: float):
	self._time_running += delta
	self._message.modulate.a += delta * (1.0/self._duration)
	
	if self._time_running > self._duration:
		return true
	return false


func run_once():
	# Whether this effect should get removed after executing it
	return true
