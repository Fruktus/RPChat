extends M_Effect
class_name M_Rmmsg

var message: Message

func init(_params: Dictionary, message: Message):
	self.message = message


func instance():
	return self


func apply(_delta: float):
	# this method should execute character logic, may be ran more than once in loop
	# if run_once returned true, the return value of this 
	self.message.get_parent().remove_child(self.message)
	return true


func run_once():
	# Whether this effect should get removed after executing it
	return true
