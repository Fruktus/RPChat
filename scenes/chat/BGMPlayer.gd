extends AudioStreamPlayer



func on_effect(effect):
	self.stream = effect.bgm
	self.play()
