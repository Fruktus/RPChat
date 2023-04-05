extends AudioStreamPlayer
# Connects to Client Effect Dispatcher via signals
# Receives effects containing audio data in effect.bgm field


func on_effect(effect):
	self.stream = effect.bgm
	self.play()
