extends VBoxContainer


func on_incoming_data(data: String):
	var message = Label.new()
	message.text = data
	self.add_child(message)
