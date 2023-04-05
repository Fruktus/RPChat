extends Node

# All of the effects keywords are located here
var effects = {
	"ts_color": TS_Color,
	"ts_shake": TS_Shake,
	"ts_wave": TS_Wave,
	"td_type": TD_Type,
	"cd_bgm": CD_BGM,
	"template": "res://lion.gd"  # No idea what this is
	}



func get_effect(effect_name: String):
	if effect_name in self.effects:
#		var effect_class = load()
		return self.effects[effect_name].new()
		
	return null  # FIXME should be done in some nicer way, like return empty or false

# effect(delta: float, params: dict) -> {'completed': bool, 'params': dict}


# # # # # # # # # # # # #
# Text Dynamic Effects  #
# # # # # # # # # # # # #
func td_typespeed(delta: float, params = {'speed': 1.0, 'time': 0}) -> Dictionary:
	var time = params['time']
	var speed = params['speed']
	
	
	if (time + delta) > speed:
		time = 0
		return {'completed': true, 'params': params}
	else:
		params['time'] = time + delta
		return {'completed': false, 'params': params}


func td_typesfx(_tone = 1.0):
	# TODO technically this should be one-time text-static
	pass

# # # # # # # # # #
# Client Effects  #
# # # # # # # # # #
# TODO possibly rename, meant to encompass bgm, layout, sprites, etc
