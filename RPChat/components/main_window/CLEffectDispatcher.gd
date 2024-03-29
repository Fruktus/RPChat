extends Node

signal audio_effect(effect)
signal bg_effect(effect)

var handlers = {C_Effect.Type.AUDIO: "audio_effect",
				C_Effect.Type.IMAGE: "bg_effect"}



func _ready():
#	if DisplayServer.screen_get_dpi() > 96:  # FIXME temporary, for testing mobile scaling
#		get_tree().set_screen_stretch(0,0,Vector2(1024,600), 3)
	set_process(false)


func on_effect(effect: C_Effect):
	# Called from Message, dispatches the effects based on type through signal
	var handler = self.handlers.get(effect.type())
	
	if handler:
		emit_signal(handler, effect)

