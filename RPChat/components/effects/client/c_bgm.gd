extends C_Effect
class_name C_BGM
# All of the effects have to implement these methods

var bgm: Resource

func init(params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	self.bgm = Storage.get_resource(params['macros'][0])

	if self.bgm:
		self.bgm.set_loop(true) 


func type():
	# returns information about type for determining handler (audio, image)
	return self.Type.AUDIO


func apply(object: Node):
	# may be ran more than once, returns true if the effect has completed and
	# can be removed
	pass


func run_once():
	# Whether this effect should get removed after executing it
	pass
