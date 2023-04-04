class_name TD_Effect
# All of the effects have to implement these methods



func init(params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass


func instance():
	pass


func apply(delta: float):
	# this method should execute character logic, may be ran more than once in loop
	# if run_once returned true, the return value of this 
	pass


func run_once():
	# Whether this effect should get removed after executing it
	pass
