extends Node

var handlers = {CD_Effect.Type.AUDIO: "audio_effect",
				CD_Effect.Type.IMAGE: "bg_effect"}

signal audio_effect(effect)
signal bg_effect(effect)


func _ready():
	set_process(false)


func on_effect(effect: CD_Effect):
	var handler = self.handlers.get(effect.type())
	
	if handler:
		emit_signal(handler, effect)

