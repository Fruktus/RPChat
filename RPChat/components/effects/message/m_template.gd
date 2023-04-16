class_name M_Effect
# All of the effects have to implement these methods



func init(_params: Dictionary, _message: Message):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	# message is a reference to the container object, so that the effect will be
	# able to influence it (for ex. transparency etc.
	pass


func instance():
	pass


func apply(_delta: float):
	# this method should execute character logic, may be ran more than once in loop
	# if run_once returned true, the return value of this 
	pass


func run_once():
	# Whether this effect should get removed after executing it
	pass
