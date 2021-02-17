class_name CD_Effect
# All of the effects have to implement these methods



func init(params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass


func instance():
	# most likely unnecessary
	pass


func apply(delta: float):
	# may be ran more than once, returns true if the effect has completed and
	# can be removed
	pass


func run_once():
	# Whether this effect should get removed after executing it
	pass
