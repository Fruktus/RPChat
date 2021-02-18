extends CD_Effect
class_name CD_BGM
# All of the effects have to implement these methods

var bgm: Resource

func init(params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	self.bgm = params['macros'][0]


func type():
	# returns information about type for determining handler (audio, image)
	return self.Type.AUDIO


func apply(delta: float):
	# may be ran more than once, returns true if the effect has completed and
	# can be removed
	pass


func run_once():
	# Whether this effect should get removed after executing it
	pass
