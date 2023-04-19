extends Effect
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
