extends M_Effect
class_name M_Waitclick

var message: Message
var finished = false



func init(_params: Dictionary, message: Message):
	self.message = message
	EventBus.connect("client_received_input", Callable(self, "on_client_received_input"))



func instance():
	return self


func apply(_delta: float):
	if finished:
		return true
	self.message.pause()
	return false


func run_once():
	# Whether this effect should get removed after executing it
	return true


func on_client_received_input():
	self.finished = true
	self.message.resume()
