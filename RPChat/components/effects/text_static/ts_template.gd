class_name TS_Effect
# All of the text-static effects have to implement these methods


func init(_params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass

func instance():
	pass

func apply(_Character: Character):
	# this method should execute character logic, may be ran more than once in loop
	pass


func run_once():
	# when effect is initialized (appended to Character) the Character
	# runs this.
	# if true, the effect is executed immediately and discarded.
	# if false, the effect will be executed in the process loop after initialization 
	pass
