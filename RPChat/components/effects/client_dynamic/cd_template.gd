class_name CD_Effect
# All of the effects have to implement these methods

enum Type {AUDIO, IMAGE}


func init(_params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass


func type():
	# returns information about type for determining handler (audio, image)
	pass 


func apply(_delta: float):
	# may be ran more than once, returns true if the effect has completed and
	# can be removed
	pass


func run_once():
	# Whether this effect should get removed after executing it
	pass
