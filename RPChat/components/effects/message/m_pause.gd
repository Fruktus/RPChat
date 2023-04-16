extends M_Effect
class_name M_Pause
# All of the effects have to implement these methods

var time_to_pause = 1.0
var _time_paused = 0.0



func init(params: Dictionary, _message: Message):
	if params['macros']:
		self.time_to_pause = float(params['macros'][0])
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present


func instance():  # TODO probably won't be needed
	return self


func apply(delta: float):
	self._time_paused += delta
	if self._time_paused > self.time_to_pause:
		return true
	return false


func run_once():
	# Whether this effect should get removed after executing it
	return true
