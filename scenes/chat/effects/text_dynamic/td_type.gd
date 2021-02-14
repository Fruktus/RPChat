extends TD_Effect
class_name TD_Type
# All of the text-static effects have to implement these methods

var time_to_pause = 1.0
var time_paused = 0.0


func init(params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass

func instance():  # TODO probably won't be needed
	return self

func apply(delta: float):
	self.time_paused += delta
	if self.time_paused > self.time_to_pause:
		self.time_paused = 0.0
		return true
	return false

func run_once():
	# Whether this effect should get removed after executing it
	return false
