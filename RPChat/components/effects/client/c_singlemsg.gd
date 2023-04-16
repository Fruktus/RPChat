extends C_Effect
class_name C_Singlemsg
# All of the effects have to implement these methods


func init(_params: Dictionary):
	# param should contain all the parameters that the effect accepts,
	# but effect should also provide defaults for those and check if params are present
	pass


func type():
	return C_Effect.Type.CLIENT


func apply(object: Node):
	# object is MainWindow
	object._clear_messages()


func run_once():
	# Whether this effect should get removed after executing it
	return false
