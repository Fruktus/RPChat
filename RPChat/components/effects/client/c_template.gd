extends Effect
class_name C_Effect
# All of the effects have to implement these methods

enum Type {AUDIO, IMAGE, MESSAGE, CLIENT}


func init(_params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass


func type() -> Type:
	# returns information about type for determining handler (audio, image)
	return Type.CLIENT


func apply(_object: Node):
	# TODO this should be compatible with other implementations,
	# get the node in init instead
	
	# the object is dependent on effect type
	# the object is element of chat window responsible for handling given effect type
	# such as AudioStreamPlayer or TextureRect.
	# The effect should know which type it wants and how to work with it
	pass
