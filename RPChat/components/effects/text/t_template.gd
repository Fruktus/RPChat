extends Effect
class_name T_Effect
# All of the text-static effects have to implement these methods


func init(_params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass

func instance() -> Effect:
	return self


func apply(_Character: Character):
	# this method should execute character logic, may be ran more than once in loop
	pass
